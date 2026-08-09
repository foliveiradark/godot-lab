# Experiment 06 — `_process()` vs `_physics_process()`

## 🎯 Objetivo

Investigar experimentalmente as diferenças entre `_process()` e `_physics_process()` e observar como cada ciclo se comporta durante a execução da Scene.

## ❓ Pergunta

> `_process()` e `_physics_process()` são executados da mesma maneira?

## 💡 Hipótese

A hipótese inicial foi que os dois métodos representam ciclos de execução diferentes e poderiam apresentar frequências de chamada distintas.

A hipótese foi mantida aberta quanto ao motivo dessa diferença, para que ele pudesse ser investigado por meio dos experimentos.

---

## 🧪 Parte 1 — Observação dos ciclos

O primeiro teste utilizou os dois métodos para exibir seus respectivos valores de `delta`:

```gdscript
func _process(delta: float) -> void:
    print("PROCESS: ", delta)

func _physics_process(delta: float) -> void:
    print("PHYSICS: ", delta)
```

### Resultado observado

Um trecho da execução apresentou:

```text
PHYSICS: 0.01666666666667
PHYSICS: 0.01666666666667
PROCESS: 0.03602366666667
PHYSICS: 0.01666666666667
PROCESS: 0.01666666666667
PROCESS: 0.009606
PHYSICS: 0.01666666666667
PROCESS: 0.008381
PROCESS: 0.00833333333333
PHYSICS: 0.01666666666667
PROCESS: 0.01111111111111
PHYSICS: 0.01666666666667
PROCESS: 0.01111111111111
PHYSICS: 0.01666666666667
PROCESS: 0.02080077777778
PROCESS: 0.01129966666667
PHYSICS: 0.01666666666667
```

### Observação

Os valores de `delta` apresentaram comportamentos diferentes:

* `_process()` apresentou valores variáveis;
* `_physics_process()` apresentou repetidamente o valor aproximado de `0.0166667` segundos;
* as chamadas dos dois métodos não ocorreram em uma simples alternância entre `PROCESS` e `PHYSICS`.

A observação indicou a existência de ciclos de processamento distintos.

---

## 🧪 Parte 2 — Medição da frequência

Para comparar quantitativamente os dois ciclos, foram criados contadores:

```gdscript
var process_count := 0
var physics_count := 0
var elapsed_time := 0.0
```

Cada método incrementava seu respectivo contador.

O tempo transcorrido foi acumulado a partir do `delta` de `_process()`:

```gdscript
elapsed_time += delta
```

Quando o tempo atingia aproximadamente um segundo, os resultados eram exibidos e a execução era encerrada.

### Resultado observado

A primeira medição apresentou:

```text
Tempo: 1.00622833333333
PROCESS: 64
PHYSICS: 60
```

Durante aproximadamente um segundo:

```text
_process()          → 64 chamadas
_physics_process()  → 60 chamadas
```

Uma segunda execução apresentou:

```text
Tempo: 1.008378
PROCESS: 62
PHYSICS: 60
```

O resultado reforçou o padrão observado anteriormente:

```text
_process()          → frequência variável
_physics_process()  → 60 chamadas no intervalo observado
```

No ambiente utilizado durante o experimento, o intervalo observado de `_physics_process()` foi aproximadamente:

```text
0.0166667 segundos
```

correspondente a aproximadamente 60 ciclos por segundo.

---

## 🧪 Parte 3 — Movimento

Para observar se a diferença entre os ciclos também poderia ser percebida visualmente, foram aplicados movimentos diferentes ao mesmo `Node2D`.

No `_process()`:

```gdscript
position.x += 100 * delta
```

No `_physics_process()`:

```gdscript
position.y += 100 * delta
```

O resultado produziu dois movimentos independentes:

```text
_process()
    ↓
movimento horizontal
    ↓
direita


_physics_process()
    ↓
movimento vertical
    ↓
abaixo
```

### Observação visual

Durante a execução:

* o Node se movimentou;
* o movimento produzido por `_process()` ocorreu para a direita;
* o movimento produzido por `_physics_process()` ocorreu para baixo;
* ambos os movimentos pareceram contínuos visualmente.

A medição correspondente foi:

```text
Tempo: 1.008378
PROCESS: 62
PHYSICS: 60
```

---

## 👀 Observações consolidadas

Os três testes produziram evidências complementares.

### `delta`

```text
_process()
    ↓
delta variável
```

Enquanto:

```text
_physics_process()
    ↓
delta aproximadamente constante
```

### Frequência

No intervalo de aproximadamente um segundo:

```text
_process()
    ↓
quantidade variável de chamadas

_physics_process()
    ↓
60 chamadas nas medições realizadas
```

### Movimento

Ambos os métodos puderam produzir movimento utilizando `delta`.

O movimento foi visualmente contínuo nos dois casos.

---

## 💡 Descoberta

O experimento demonstrou que `_process()` e `_physics_process()` representam ciclos de execução distintos.

O comportamento observado pode ser resumido como:

```text
_process()
    ├── executa continuamente
    ├── intervalo entre chamadas pode variar
    ├── delta acompanha o intervalo observado
    └── pode ser utilizado para atualizar o estado geral da Scene
```

Enquanto:

```text
_physics_process()
    ├── utiliza um intervalo de processamento fixo
    ├── apresentou aproximadamente 0.0166667 s por ciclo
    ├── apresentou 60 chamadas no intervalo observado
    └── também recebe delta
```

Uma consequência importante observada foi que `delta` permite que o movimento seja calculado em função do tempo transcorrido, mesmo quando o intervalo entre chamadas varia.

---

## 🧠 Relação com o Experiment 05

No Experiment 05 foi observado que utilizar:

```gdscript
position.x += 100 * delta
```

faz com que o deslocamento seja proporcional ao tempo.

O Experiment 06 mostrou que o mesmo princípio pode ser aplicado tanto em `_process()` quanto em `_physics_process()`.

A diferença está no comportamento dos ciclos que fornecem esse `delta`.

Assim:

```text
Experiment 05
    ↓
delta representa tempo transcorrido


Experiment 06
    ↓
diferentes ciclos utilizam esse tempo
    ↓
_process()
_physics_process()
```

---

## ⚠️ Limites da descoberta

O experimento foi realizado em um ambiente específico e com uma execução curta.

Portanto, não devemos generalizar os resultados numéricos como regras universais.

Em particular, o experimento demonstrou que:

> `_physics_process()` executou 60 vezes durante aproximadamente um segundo nas medições realizadas.

Não foi demonstrado que ele necessariamente executará exatamente 60 vezes por segundo em qualquer configuração.

Também não foi investigado ainda como o comportamento dos dois ciclos reage a cargas maiores de processamento.

A finalidade deste experimento foi compreender a diferença básica entre os dois ciclos por meio da observação.

---

## ✅ Resultado

A hipótese inicial foi **confirmada parcialmente**.

Foi demonstrado experimentalmente que:

* `_process()` e `_physics_process()` são ciclos distintos;
* `_process()` apresentou `delta` variável;
* `_physics_process()` apresentou `delta` aproximadamente constante;
* `_physics_process()` realizou 60 chamadas nas medições realizadas;
* ambos os métodos recebem `delta`;
* ambos podem ser utilizados para produzir movimento;
* o movimento pode permanecer contínuo quando calculado proporcionalmente ao tempo.

O experimento forneceu uma primeira compreensão prática da existência de diferentes ciclos de processamento na Godot.

---

## 📌 Próximo experimento

Investigar o comportamento de `_physics_process()` quando o processamento sofre uma carga maior.

A questão que orientará o próximo experimento será:

> **O que acontece com o ciclo de física quando o processamento fica mais pesado?**
