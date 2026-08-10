# Experiment 09 — Entrada do jogador e ciclo de atualização

## 🎯 Objetivo

Investigar como uma entrada do jogador é detectada e processada pelo Godot durante os ciclos de atualização.

O experimento busca compreender a relação entre:

```text
entrada do jogador
        ↓
detecção da entrada
        ↓
processamento do evento
        ↓
alteração de estado
        ↓
comportamento observável
```

## ❓ Pergunta

> **Como a entrada do jogador é detectada e processada pelo Godot durante os ciclos de atualização?**

## 🧠 Premissa

O Godot fornece mecanismos para que um Node receba eventos de entrada.

Antes deste experimento, já havíamos investigado os ciclos `_process()` e `_physics_process()`, mas ainda não havíamos observado diretamente como uma ação do jogador chega ao código.

A investigação foi conduzida sem assumir inicialmente que a entrada deveria ser consultada dentro de um ciclo contínuo.

## 🧪 Condição experimental

Foi utilizado o `Node2D` raiz da cena existente, utilizando temporariamente seu `main.gd`.

O experimento foi dividido em três observações:

1. identificar os eventos recebidos pelo Node;
2. comparar a chegada dos eventos com `_process()`;
3. utilizar uma entrada para alterar o estado e o comportamento do Node.

Nenhum personagem, sistema de controles ou Input Map foi criado.

---

## 🔬 Etapa 1 — observar eventos de entrada

Inicialmente, o script foi configurado para imprimir todos os eventos recebidos:

```gdscript
extends Node2D


func _ready() -> void:
	print("O Node entrou na Scene Tree!")


func _input(event: InputEvent) -> void:
	print(event)
```

Ao pressionar e liberar `Space`, foram observados:

```text
InputEventKey: keycode=32 (Space), mods=none, physical=false, location=unspecified, pressed=true, echo=false
InputEventKey: keycode=32 (Space), mods=none, physical=false, location=unspecified, pressed=false, echo=false
```

### Observação

Uma única interação com a tecla produziu dois eventos distintos:

```text
pressed=true
    ↓
tecla pressionada

pressed=false
    ↓
tecla liberada
```

Também foi observado um `InputEventMouseMotion` quando o mouse foi movimentado sobre a janela.

Isso revelou que `_input()` não recebe exclusivamente eventos de teclado.

Ele recebe eventos de entrada em geral, que podem ser de diferentes tipos.

---

## 🔬 Etapa 2 — entrada e `_process()`

Para observar a relação entre eventos de entrada e o ciclo contínuo de atualização, foi adicionada uma saída ao `_process()`:

```gdscript
func _process(delta: float) -> void:
	print("PROCESS")


func _input(event: InputEvent) -> void:
	print("INPUT: ", event)
```

Durante a execução, foram observadas sequências como:

```text
PROCESS
PROCESS
PROCESS
PROCESS
INPUT: InputEventKey: keycode=32 (Space), mods=none, physical=false, location=unspecified, pressed=true, echo=false
PROCESS
PROCESS
PROCESS
PROCESS
```

### Observação

O evento de entrada apareceu entre chamadas sucessivas de `_process()`.

Isso demonstrou experimentalmente que:

- `_process()` continua sendo executado continuamente;
- `_input()` recebe eventos quando eles ocorrem;
- a detecção de entrada não depende de imprimir ou consultar a entrada a cada execução de `_process()`.

### Limite da observação

A medição não deve ser interpretada como uma regra absoluta de que `_input()` sempre ocorrerá exatamente entre duas chamadas de `_process()`.

O que foi demonstrado foi que, durante a execução observada, os eventos de entrada foram entregues independentemente do ciclo contínuo de `_process()`.

---

## 🔬 Etapa 3 — entrada alterando estado

Após compreender a natureza dos eventos, foi introduzido um estado simples:

```gdscript
var contador := 0
```

O evento foi filtrado para considerar apenas eventos de teclado em estado pressionado:

```gdscript
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		contador += 1
		print("Entrada detectada! Contador: ", contador)
```

Foram realizadas três pressões da tecla `Space`.

Resultado observado:

```text
Entrada detectada! Contador: 1
Entrada detectada! Contador: 2
Entrada detectada! Contador: 3
```

Entre as entradas, `_process()` continuou sendo executado repetidamente.

### Observação

O contador foi alterado pela ocorrência dos eventos de entrada e não pela quantidade de execuções de `_process()`.

Isso permitiu distinguir:

```text
_process()
    ↓
ciclo contínuo de atualização
```

de:

```text
_input(event)
    ↓
resposta a um evento de entrada
```

---

## 🔬 Etapa 4 — entrada produzindo comportamento

Na última etapa, a entrada foi utilizada para modificar diretamente a posição do Node:

```gdscript
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		contador += 1
		position.x += 50
		print("Entrada detectada! Contador: ", contador)
		print("Position x: ", position.x)
```

A tecla `Space` foi pressionada três vezes.

Resultado:

```text
Entrada detectada! Contador: 1
Position x: 50.0

Entrada detectada! Contador: 2
Position x: 100.0

Entrada detectada! Contador: 3
Position x: 150.0
```

### Observação

Cada pressão da tecla produziu uma alteração correspondente na posição:

```text
Space
  ↓
_input()
  ↓
position.x += 50
```

O movimento não dependia de `_process()` nem de `delta`.

Foi uma consequência direta da ocorrência do evento de entrada.

---

## 🧠 Descobertas

O experimento permitiu observar quatro características importantes.

### 1. Entrada chega como evento

O Node pode receber objetos derivados de `InputEvent`.

No caso do teclado:

```text
InputEventKey
```

### 2. Pressionar e liberar são estados distintos

Uma tecla pode produzir:

```text
pressed=true
```

e posteriormente:

```text
pressed=false
```

### 3. `_input()` não é um ciclo contínuo

Diferentemente de `_process()`, `_input()` não foi observado executando continuamente.

Ele foi acionado pela ocorrência de eventos de entrada.

### 4. Um evento pode alterar diretamente o estado do jogo

A partir de `_input()`, foi possível alterar:

```text
contador
```

e:

```text
position.x
```

demonstrando a cadeia:

```text
entrada
   ↓
evento
   ↓
_input()
   ↓
estado
   ↓
comportamento
```

---

## 🔗 Relação com experimentos anteriores

O Experiment 09 amplia o conhecimento construído anteriormente:

```text
Experiment 05
    ↓
delta representa intervalo de tempo


Experiment 06
    ↓
_process() e _physics_process()
possuem ciclos diferentes


Experiment 07
    ↓
carga pode afetar a frequência
dos ciclos


Experiment 08
    ↓
delta permite movimento aproximadamente
equivalente entre os ciclos


Experiment 09
    ↓
entrada do jogador chega como evento
e pode alterar diretamente o estado
```

O conjunto começa a formar uma visão mais completa do fluxo de execução de um jogo:

```text
              JOGADOR
                 │
                 │ entrada
                 ▼
            _input(event)
                 │
                 ▼
              ESTADO
                 │
                 ▼
           COMPORTAMENTO


_process() ──────────────► atualização contínua

_physics_process() ──────► atualização física
```

---

## ⚠️ Limites da conclusão

O experimento não investigou:

- `InputMap`;
- ações configuradas pelo projeto;
- `Input.is_action_pressed()`;
- movimento contínuo;
- aceleração;
- física;
- controle de personagem;
- múltiplas entradas simultâneas;
- tratamento de eventos em `_physics_process()`.

Portanto, nenhuma conclusão sobre esses mecanismos deve ser inferida a partir deste experimento.

O objetivo foi exclusivamente compreender a chegada e o processamento básico de eventos de entrada.

---

## 🎯 Conclusão

A pergunta do experimento foi respondida:

> **A entrada do jogador é recebida pelo Godot como um evento de entrada, que pode ser processado pelo método `_input()` independentemente da execução contínua de `_process()`. Esse evento pode ser filtrado e utilizado para alterar diretamente o estado e o comportamento de um Node.**

O experimento demonstrou, na prática, a transição:

```text
entrada do jogador
        ↓
InputEvent
        ↓
_input()
        ↓
alteração de estado
        ↓
comportamento observável
```

A investigação foi encerrada neste ponto porque a pergunta original foi respondida sem necessidade de introduzir sistemas adicionais.

## 📌 Próximo passo

O próximo experimento deverá partir de uma nova pergunta surgida a partir desta descoberta.

Não será introduzido um sistema completo de controle enquanto não houver uma necessidade experimental ou arquitetural que justifique sua investigação.