# Experiment 08 — Movimento e ciclo de atualização

## 🎯 Objetivo

Investigar se o movimento baseado em `delta` apresenta comportamento equivalente quando executado em `_process()` e `_physics_process()`.

O experimento busca observar se a diferença entre os ciclos de atualização interfere na velocidade de movimento quando a mesma lógica é utilizada.

## ❓ Pergunta

> O movimento baseado em `delta` se comporta da mesma forma quando executado em `_process()` e em `_physics_process()`?

## 🧠 Premissa

Os ciclos `_process()` e `_physics_process()` possuem frequências de atualização diferentes.

Entretanto, ambos fornecem o intervalo de tempo (`delta`) correspondente à atualização.

O experimento busca verificar se utilizar esse valor no cálculo do movimento é suficiente para manter velocidades equivalentes nos dois ciclos.

## 🧪 Condição experimental

Foram utilizados dois `Node2D` independentes:

```text
Node2D
├── MovimentoProcess
│   └── Label
└── MovimentoPhysics
    └── Label
```

Os Nodes foram posicionados separadamente na viewport para permitir a observação visual dos movimentos.

O `main.gd` foi temporariamente utilizado apenas como infraestrutura de medição, evitando que o Node raiz interferisse no movimento dos objetos.

### Movimento em `_process()`

O Node `MovimentoProcess` utilizou:

```gdscript
extends Node2D


func _process(delta: float) -> void:
    position.x += 100 * delta
```

### Movimento em `_physics_process()`

O Node `MovimentoPhysics` utilizou:

```gdscript
extends Node2D


func _physics_process(delta: float) -> void:
    position.x += 100 * delta
```

A lógica de movimento foi mantida propositalmente igual nos dois Nodes.

A única diferença foi o ciclo responsável por executá-la.

## 👀 Observação inicial

Durante a primeira execução, os dois movimentos pareceram visualmente muito semelhantes.

Foi percebida uma diferença mínima, com o `PROCESS` aparentando deslocar-se ligeiramente mais rápido que o `PHYSICS`.

A diferença foi considerada pequena demais para ser avaliada visualmente com segurança.

Isso levou à necessidade de uma medição objetiva.

## 📏 Primeira medição

A execução foi acompanhada durante aproximadamente 2 segundos.

Resultado:

```text
Tempo: 2.00791433333333
PROCESS position.x: 299.124877929688
PHYSICS position.x: 300.000091552734
```

A diferença entre as posições foi de aproximadamente:

```text
0.88 pixel
```

O resultado indicou que os movimentos estavam muito próximos, mas uma segunda medição foi realizada para verificar se essa diferença se acumularia ao longo do tempo.

## 📏 Segunda medição

A janela de medição foi ampliada para aproximadamente 10 segundos, mantendo os demais parâmetros inalterados.

Resultado:

```text
Tempo: 10.0094956666667
PROCESS position.x: 1099.2861328125
PHYSICS position.x: 1100.00317382812
```

A diferença entre as posições foi de aproximadamente:

```text
0.72 pixel
```

## 📊 Comparação

| Tempo | PROCESS | PHYSICS | Diferença aproximada |
|---:|---:|---:|---:|
| ~2 s | 299,12 | 300,00 | 0,88 px |
| ~10 s | 1099,29 | 1100,00 | 0,72 px |

A diferença observada não aumentou com o tempo.

Dentro das condições do experimento, os dois movimentos permaneceram praticamente equivalentes.

## 💡 Descoberta

O experimento demonstrou que, quando a mesma lógica de movimento utiliza `delta`, `_process()` e `_physics_process()` podem produzir velocidades de movimento praticamente equivalentes, mesmo possuindo ciclos de atualização diferentes.

Neste caso, ambos os Nodes se aproximaram de uma velocidade de:

```text
100 pixels por segundo
```

O uso de `delta` permite que o deslocamento considere o intervalo de tempo efetivamente transcorrido entre as atualizações.

## ⚠️ Limites da conclusão

O experimento não demonstra que `_process()` e `_physics_process()` são intercambiáveis.

A conclusão está limitada às condições testadas:

- movimento simples em um `Node2D`;
- velocidade constante;
- uso de `delta`;
- ausência de carga artificial;
- ausência de interação física;
- execução no ambiente atual do laboratório.

Os dois ciclos continuam possuindo finalidades diferentes.

O experimento apenas demonstrou que a diferença de frequência entre eles não produziu uma diferença significativa na velocidade do movimento testado.

## 🎮 Relação com desenvolvimento de jogos

O experimento fornece uma primeira evidência prática de que o cálculo de movimento baseado em `delta` ajuda a desacoplar a velocidade desejada da quantidade de atualizações realizadas.

Isso é relevante para jogos porque diferentes sistemas podem operar em ciclos diferentes, e o comportamento desejado não deve depender simplesmente da quantidade de frames processados.

Entretanto, a escolha entre `_process()` e `_physics_process()` continua sendo uma decisão relacionada ao tipo de comportamento implementado.

## 🔄 Relação com experimentos anteriores

O experimento amplia as descobertas anteriores:

```text
Experiment 05
    ↓
delta representa o intervalo de tempo entre atualizações

Experiment 06
    ↓
_process() e _physics_process() possuem ciclos diferentes

Experiment 07
    ↓
carga pode afetar a frequência de _process()

Experiment 08
    ↓
mesmo com ciclos diferentes,
o uso de delta manteve o movimento aproximadamente equivalente
```

## ✅ Resultado

A pergunta do experimento foi respondida:

> **Nas condições testadas, o movimento baseado em `delta` apresentou comportamento praticamente equivalente quando executado em `_process()` e `_physics_process()`.**

A diferença observada entre os dois movimentos foi pequena e não apresentou crescimento ao longo do período de medição.

O experimento foi encerrado porque a pergunta inicial foi respondida sem necessidade de medições adicionais.

## 📌 Próximo experimento

O próximo experimento deverá partir de uma nova pergunta decorrente do conhecimento adquirido, evitando introduzir novas funcionalidades antes que exista uma necessidade de investigação.