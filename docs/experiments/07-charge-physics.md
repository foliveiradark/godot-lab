# Experiment 07 — Carga de processamento e física

## 🎯 Objetivo

Investigar o comportamento de `_process()` e `_physics_process()` quando o processamento realizado em `_process()` recebe uma carga significativa.

A questão central foi:

> **O que acontece com o ciclo de física quando o processamento fica mais pesado?**

---

## 💡 Contexto

No Experiment 06 observamos que `_process()` e `_physics_process()` possuem ciclos de execução diferentes.

Durante as medições anteriores:

* `_process()` apresentou frequência variável;
* `_physics_process()` apresentou aproximadamente 60 chamadas por segundo;
* o `delta` de `_physics_process()` permaneceu próximo de `0,01667` segundos.

O Experiment 07 buscou verificar se essa diferença permaneceria quando `_process()` estivesse sob uma carga maior.

---

## 🧪 Experimento 1 — Baseline

Antes de introduzir qualquer carga adicional, foi realizada uma medição durante aproximadamente dois segundos.

O código contou as chamadas de `_process()` e `_physics_process()`:

```gdscript
var process_count := 0
var physics_count := 0
var elapsed_time := 0.0
```

### Resultado

```text
Tempo: 2.01050533333333
PROCESS: 123
PHYSICS: 120
```

Esse resultado foi utilizado como referência para a comparação.

Em aproximadamente dois segundos:

```text
_process()          → 123 chamadas
_physics_process()  → 120 chamadas
```

---

## 🧪 Experimento 2 — Introdução de carga

Foi introduzida uma operação computacional significativa dentro de `_process()`:

```gdscript
var resultado := 0.0

for i in range(1_000_000):
    resultado += sqrt(i)
```

Nenhuma carga equivalente foi adicionada a `_physics_process()`.

O restante da estrutura de medição foi mantido.

### Resultado

```text
Tempo: 2.05286676286676
PROCESS: 17
PHYSICS: 123
```

### Observação

A diferença em relação ao baseline foi significativa:

```text
PROCESS
123 → 17 chamadas
```

Enquanto:

```text
PHYSICS
120 → 123 chamadas
```

A carga aplicada em `_process()` reduziu drasticamente a quantidade de chamadas observadas nesse ciclo.

O número de chamadas de `_physics_process()` permaneceu próximo do resultado anterior.

---

## 🧪 Experimento 3 — Medição do `delta` de física

Para verificar se a estabilidade observada no contador também estava presente no intervalo entre os ciclos de física, foi adicionado:

```gdscript
print("PHYSICS delta: ", delta)
```

dentro de `_physics_process()`.

A carga utilizada no experimento anterior foi mantida:

```gdscript
for i in range(1_000_000):
    resultado += sqrt(i)
```

### Resultado

Os valores observados para `PHYSICS delta` permaneceram repetidamente próximos de:

```text
0.01666666666667
```

A medição final apresentou:

```text
Tempo: 2.04348433333333
PROCESS: 16
PHYSICS: 122
```

---

## 📊 Comparação dos resultados

| Condição                   | Tempo aproximado | `_process()` | `_physics_process()` |
| -------------------------- | ---------------: | -----------: | -------------------: |
| Sem carga                  |           2,01 s |          123 |                  120 |
| Com carga                  |           2,05 s |           17 |                  123 |
| Com carga + medição física |           2,04 s |           16 |                  122 |

A comparação mostrou uma diferença clara no comportamento dos dois ciclos.

---

## 👀 Observações

A partir das execuções realizadas:

### `_process()`

A frequência observada foi fortemente afetada pela carga adicionada.

```text
123 chamadas
      ↓
17 chamadas
      ↓
16 chamadas
```

### `_physics_process()`

A quantidade de chamadas permaneceu próxima de 60 por segundo:

```text
120
 ↓
123
 ↓
122
```

Além disso, o valor observado de `delta` permaneceu próximo de:

```text
0,01667 s
```

---

## 💡 Descoberta

Nas condições utilizadas no experimento:

> **Uma carga significativa executada dentro de `_process()` reduziu drasticamente a frequência observada de `_process()`, enquanto `_physics_process()` manteve aproximadamente 60 execuções por segundo e intervalos próximos de 0,01667 segundos.**

Isso reforça experimentalmente a existência de comportamentos distintos entre os dois ciclos.

A observação também ajuda a compreender por que a Godot disponibiliza um ciclo específico para processamento de física.

---

## ⚠️ Limites da descoberta

O experimento foi realizado:

* em uma máquina específica;
* utilizando uma carga computacional específica;
* durante aproximadamente dois segundos;
* com a configuração padrão utilizada no laboratório.

Portanto, os resultados não devem ser interpretados como uma garantia universal de que `_physics_process()` sempre permanecerá em 60 Hz independentemente da carga.

O que foi demonstrado foi o comportamento **nas condições testadas**.

Também não foi investigado neste experimento o comportamento da física quando a própria lógica de `_physics_process()` recebe uma carga excessiva.

Essa investigação seria um experimento diferente.

---

## 🧠 Relação com os experimentos anteriores

O experimento complementa diretamente o conhecimento adquirido anteriormente:

```text
Experiment 05
    ↓
delta representa tempo transcorrido

Experiment 06
    ↓
_process() e _physics_process()
possuem ciclos diferentes

Experiment 07
    ↓
uma carga em _process()
afeta fortemente seu próprio ciclo
```

A sequência permite compreender que `delta` não deve ser analisado isoladamente.

Ele está relacionado ao ciclo de processamento que está executando o código.

---

## 🎯 Aprendizado para desenvolvimento

O experimento não pretende estabelecer uma regra completa sobre onde cada tipo de código deve ser colocado.

Porém, ele fornece uma evidência prática importante:

> **A escolha entre `_process()` e `_physics_process()` está relacionada ao tipo de atualização que estamos realizando e ao ciclo em que essa atualização precisa ocorrer.**

Essa compreensão será importante posteriormente para investigar:

* movimento;
* colisões;
* gravidade;
* interação do jogador;
* lógica dependente de física.

Esses assuntos serão tratados em experimentos específicos, evitando antecipar conclusões.

---

## 🛑 Critério de encerramento

O experimento foi encerrado após responder à pergunta inicial com evidência suficiente.

Não foram realizados testes adicionais aumentando progressivamente a carga, pois isso transformaria o experimento em uma investigação de desempenho da engine, desviando do objetivo de aprendizagem do laboratório.

A existência de outras perguntas interessantes não constitui, por si só, motivo para prolongar o experimento.

---

## ✅ Resultado

A pergunta:

> **O que acontece com o ciclo de física quando o processamento fica mais pesado?**

foi respondida nas condições testadas.

Foi observado que:

* a carga em `_process()` reduziu drasticamente sua frequência de execução;
* `_physics_process()` continuou apresentando aproximadamente 60 chamadas por segundo;
* o `delta` de `_physics_process()` permaneceu próximo de `0,01667` segundos;
* os dois ciclos apresentaram comportamentos distintos sob a condição de carga.

O experimento forneceu uma evidência prática sobre a separação entre o processamento geral e o ciclo de física da Godot.

---

## 📌 Próximo experimento

O próximo experimento deverá investigar uma questão relacionada ao movimento:

> **O que muda quando um movimento baseado em `delta` é executado em `_process()` ou em `_physics_process()`?**
