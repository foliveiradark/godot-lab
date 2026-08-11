# Experiment 10 — Separação entre entrada e comportamento

## 🎯 Objetivo

Investigar como separar a detecção de uma entrada do jogador da lógica responsável por transformar essa entrada em comportamento.

O experimento parte da relação observada no Experiment 09:

```text
entrada do jogador
        ↓
_input()
        ↓
alteração de estado
        ↓
comportamento
```

A investigação busca verificar se é possível introduzir uma etapa intermediária entre a entrada e o comportamento.

---

## ❓ Pergunta

> **Como separar a entrada do jogador da lógica que transforma essa entrada em comportamento?**

---

## 🧠 Contexto

No Experiment 09, uma pressão da tecla `Space` era detectada pelo `_input()` e provocava diretamente uma alteração na posição do Node:

```text
Space
  ↓
_input()
  ↓
position.x += 50
```

Embora essa abordagem tenha demonstrado que uma entrada pode produzir comportamento, ela mistura duas responsabilidades no mesmo ponto do código:

1. detectar a entrada;
2. executar o comportamento.

O Experiment 10 investiga se essas responsabilidades podem ser separadas.

---

## 🧪 Premissa

Uma entrada do jogador pode ser interpretada como uma intenção que posteriormente será consumida pela lógica responsável pelo comportamento.

A hipótese inicial foi representada por:

```text
entrada
   ↓
detecção
   ↓
intenção
   ↓
comportamento
```

Essa estrutura foi tratada apenas como hipótese experimental, não como decisão arquitetural definitiva.

---

## 🚧 Regra experimental

Foi estabelecida uma regra explícita:

> **A função responsável por detectar a entrada não pode alterar `position.x` diretamente.**

Portanto, o `_input()` poderia detectar e registrar uma intenção, mas não poderia executar diretamente o movimento.

Essa regra permitiu verificar objetivamente se a entrada e o comportamento poderiam ser separados.

---

## 🔬 Etapa 1 — estabelecer a linha de base

Inicialmente, o comportamento foi reduzido ao mínimo:

```gdscript
extends Node2D


func _ready() -> void:
	print("O Node entrou na Scene Tree!")
```

Nenhum tratamento de entrada foi utilizado.

Durante a execução, o Node permaneceu parado.

### Observação

A ausência de entrada e de lógica de comportamento resultou em:

```text
entrada
  ↓
nenhuma
  ↓
Node parado
```

Essa condição serviu como linha de base para as etapas seguintes.

---

## 🔬 Etapa 2 — detectar entrada sem executar comportamento

Foi introduzido um estado intermediário:

```gdscript
var deve_mover := false
```

O tratamento da entrada foi implementado da seguinte forma:

```gdscript
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		deve_mover = true
		print("Intenção de movimento registrada")
```

Durante a execução, uma pressão da tecla `Space` produziu:

```text
O Node entrou na Scene Tree!
Intenção de movimento registrada.
```

O Node permaneceu parado.

### Observação

A entrada foi detectada e transformada em estado:

```text
Space
  ↓
_input()
  ↓
deve_mover = true
```

Porém, nenhum movimento foi executado.

Isso demonstrou que a detecção da entrada poderia ocorrer sem executar diretamente o comportamento.

---

## 🔬 Etapa 3 — consumir a intenção em outro ponto do ciclo

Na etapa seguinte, o `_process()` passou a consumir o estado produzido pelo `_input()`:

```gdscript
func _process(delta: float) -> void:
	if deve_mover:
		position.x += 50
		deve_mover = false
```

O tratamento da entrada permaneceu responsável apenas pela detecção e registro da intenção:

```gdscript
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		deve_mover = true
		print("Intenção de movimento registrada")
```

O fluxo experimental passou a ser:

```text
Space
  ↓
_input()
  ↓
deve_mover = true
  ↓
_process()
  ↓
position.x += 50
  ↓
deve_mover = false
```

### Resultado observado

Foram realizadas três pressões da tecla `Space`.

O console apresentou:

```text
O Node entrou na Scene Tree!
Intenção de movimento registrada.
Intenção de movimento registrada.
Intenção de movimento registrada.
```

Visualmente, a cada pressionamento da tecla, os textos associados aos Nodes deslocaram-se para a direita.

### Observação

Cada entrada provocou uma alteração de posição, mesmo que a alteração de `position.x` não estivesse presente no `_input()`.

Isso confirmou experimentalmente que uma entrada pode:

1. ser detectada;
2. produzir uma intenção;
3. ser consumida posteriormente;
4. gerar comportamento.

---

## 🧠 Descoberta principal

O experimento demonstrou uma separação possível entre:

```text
ENTRADA
   ↓
_input()
```

e:

```text
COMPORTAMENTO
   ↓
_process()
```

A variável intermediária funcionou como uma intenção pendente:

```text
false
  ↓
entrada
  ↓
true
  ↓
_process()
  ↓
movimento
  ↓
false
```

Assim, o `_input()` deixou de conhecer diretamente o mecanismo utilizado para realizar o movimento.

Ele apenas registrou:

> **"Existe uma solicitação de movimento."**

A lógica de comportamento ficou responsável por decidir o que fazer com essa solicitação.

---

## 🔗 Comparação com o Experiment 09

No Experiment 09, o fluxo era:

```text
Space
  ↓
_input()
  ↓
position.x += 50
```

No Experiment 10, o fluxo passou a ser:

```text
Space
  ↓
_input()
  ↓
deve_mover = true
  ↓
_process()
  ↓
position.x += 50
```

A principal diferença é a introdução de uma fronteira entre:

```text
detecção da entrada
```

e:

```text
execução do comportamento
```

---

## 🌳 Observação sobre a hierarquia de Nodes

Durante a execução, foi observado que os textos associados aos Nodes também se deslocaram para a direita.

Isso ocorreu porque o `main.gd` estava associado ao `Node2D` raiz da cena.

A alteração:

```gdscript
position.x += 50
```

afetou a posição do Node pai e, consequentemente, a posição visual de seus elementos descendentes.

A relação observada foi:

```text
Node2D
   │
   └── Label
```

Ao mover o Node2D:

```text
Node2D  →  direita
   │
   └── Label  →  direita
```

### Limite da observação

Essa observação demonstra o efeito da transformação do Node pai sobre seus descendentes dentro da árvore de cena, mas não investiga detalhadamente o sistema de transformações do Godot.

Esse assunto poderá ser investigado separadamente caso surja uma necessidade futura.

---

## 🔬 Evidências

### Linha de base

```text
O Node entrou na Scene Tree!
```

Node parado.

### Entrada sem comportamento

```text
O Node entrou na Scene Tree!
Intenção de movimento registrada.
```

Node permaneceu parado.

### Entrada separada do comportamento

```text
O Node entrou na Scene Tree!
Intenção de movimento registrada.
Intenção de movimento registrada.
Intenção de movimento registrada.
```

Cada pressionamento provocou deslocamento visual para a direita.

---

## 🧩 Relação com experimentos anteriores

O Experiment 10 amplia diretamente o conhecimento obtido no Experiment 09.

```text
Experiment 09
    ↓
entrada do jogador chega como evento
    ↓
_input()
    ↓
estado pode ser alterado
```

Agora:

```text
Experiment 10
    ↓
entrada do jogador chega como evento
    ↓
_input()
    ↓
intenção
    ↓
_process()
    ↓
comportamento
```

A sequência de experimentos passa a representar uma evolução conceitual:

```text
05 — delta e tempo
        ↓
06 — process vs physics
        ↓
07 — carga de processamento e física
        ↓
08 — movimento e ciclos de atualização
        ↓
09 — entrada e ciclo de atualização
        ↓
10 — separação entre entrada e comportamento
```

---

## ⚠️ Limites da conclusão

O experimento demonstrou uma forma possível de separar entrada e comportamento, mas não permite concluir que:

- `_process()` seja necessariamente o lugar correto para todo comportamento;
- uma variável booleana seja a melhor representação de intenção;
- `_input()` deva sempre produzir estados intermediários;
- sinais sejam necessários;
- `InputMap` seja melhor ou pior;
- essa estrutura seja uma arquitetura definitiva para o projeto.

Também não foram investigados:

- múltiplas intenções simultâneas;
- entradas contínuas;
- `InputMap`;
- `Input.is_action_pressed()`;
- controle por gamepad;
- máquina de estados;
- comandos;
- sinais.

Esses mecanismos somente deverão ser investigados caso uma pergunta futura exija isso.

---

## 🎯 Conclusão

A pergunta do experimento foi:

> **Como separar a entrada do jogador da lógica que transforma essa entrada em comportamento?**

A investigação demonstrou que uma possibilidade é utilizar uma informação intermediária entre a detecção da entrada e a execução do comportamento.

O fluxo observado foi:

```text
entrada do jogador
        ↓
_input()
        ↓
intenção
        ↓
_process()
        ↓
comportamento
```

Nesse modelo experimental:

- `_input()` detectou a entrada;
- uma variável registrou a intenção;
- `_process()` consumiu essa intenção;
- o comportamento foi executado fora do tratamento direto da entrada.

Portanto, foi demonstrado experimentalmente que **a detecção de uma entrada pode ser separada da lógica que executa o comportamento resultante**.

A investigação foi encerrada neste ponto porque a pergunta original foi respondida sem necessidade de introduzir abstrações adicionais.

---

## 📌 Próximo passo

O próximo experimento deverá surgir de uma nova lacuna identificada a partir desse conhecimento.

Não serão introduzidos mecanismos adicionais apenas para sofisticar a solução atual.