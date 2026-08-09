# Experiment 05 — `delta` e tempo de execução

## 🎯 Objetivo

Investigar o significado do parâmetro `delta` recebido pela função `_process()` e sua relação com o movimento durante a execução da Scene.

## 🧪 Hipótese

> `delta` representa o intervalo de tempo transcorrido entre uma execução de `_process()` e a seguinte.

Para investigar essa hipótese, o valor de `delta` foi exibido no terminal durante a execução.

## 🔬 Experimento

Inicialmente, o `_process()` foi alterado para exibir somente o valor de `delta`:

```gdscript
func _process(delta: float) -> void:
    print(delta)
```

Foram observados valores variáveis, como:

```text
0.062916
0.00671
0.01973
0.01760533333333
0.006147
0.00862
0.01666666666667
0.02238666666667
0.01666666666667
0.009349
```

A maioria dos valores observados ficou próxima de `0.016` segundos, mas ocorreram valores maiores e menores.

Em seguida, o movimento foi alterado para:

```gdscript
func _process(delta: float) -> void:
    position.x += 100 * delta
```

O movimento visual ficou mais rápido e passou a ser proporcional ao tempo transcorrido.

Por fim, foram exibidos simultaneamente `delta` e a posição:

```gdscript
func _process(delta: float) -> void:
    position.x += 100 * delta
    print("delta: ", delta, " | position.x: ", position.x)
```

Um trecho da execução apresentou:

```text
delta: 0.03197866666667 | position.x: 3.19786667823792
delta: 0.01666666666667 | position.x: 4.86453342437744
delta: 0.01527777777778 | position.x: 6.39231109619141
delta: 0.00900822222222 | position.x: 7.29313325881958
delta: 0.005403 | position.x: 7.83343315124512
```

Os valores confirmaram que o deslocamento realizado em cada atualização corresponde a aproximadamente:

```text
100 × delta
```

Por exemplo:

```text
100 × 0.031978666... ≈ 3.197866...
```

e:

```text
100 × 0.016666666... ≈ 1.666666...
```

## 👀 Observações

* `_process()` é executado repetidamente durante a execução.
* O valor de `delta` não é constante.
* Foram observados valores próximos de `0.016666`, mas também intervalos maiores e menores.
* Quando `delta` aumenta, o deslocamento calculado por `100 * delta` também aumenta.
* Quando `delta` diminui, o deslocamento também diminui.
* O movimento utilizando `100 * delta` apresentou comportamento proporcional ao tempo.

## 💡 Descoberta

`delta` representa o tempo transcorrido entre atualizações de `_process()`, expresso em segundos.

Ao utilizar:

```gdscript
position.x += 100 * delta
```

o movimento deixa de ser definido simplesmente como:

```text
1 unidade por atualização
```

e passa a representar aproximadamente:

```text
100 unidades por segundo
```

A relação observada foi:

```text
velocidade × tempo
        ↓
100 × delta
        ↓
deslocamento
```

## 🔎 Comparação com o Experiment 04

No experimento anterior foi utilizado:

```gdscript
position.x += 1
```

Nesse caso, o deslocamento dependia diretamente da quantidade de atualizações realizadas.

Neste experimento foi utilizado:

```gdscript
position.x += 100 * delta
```

Nesse caso, o deslocamento é proporcional ao tempo transcorrido.

A diferença observada pode ser representada como:

```text
Experiment 04
1 unidade / atualização
```

versus:

```text
Experiment 05
100 unidades / segundo
```

## ⚠️ Limite da descoberta

O experimento demonstrou experimentalmente o comportamento de `delta` e sua utilização para calcular deslocamento proporcional ao tempo.

Ainda não foram investigados outros mecanismos de processamento da Godot, como `_physics_process()`, nem diferenças entre processamento de física e processamento geral.

Esses conceitos serão investigados posteriormente.

## ✅ Resultado

A hipótese inicial foi considerada **confirmada pelos dados observados**.

O experimento permitiu compreender experimentalmente que:

* `delta` representa um intervalo de tempo em segundos;
* seu valor pode variar entre chamadas de `_process()`;
* `_process()` não deve ser tratado simplesmente como uma quantidade fixa de atualizações por segundo;
* multiplicar uma velocidade por `delta` permite calcular um deslocamento proporcional ao tempo transcorrido.

## 📌 Próximo experimento

Investigar a diferença entre `_process()` e `_physics_process()` e compreender por que a Godot possui diferentes ciclos de processamento.
