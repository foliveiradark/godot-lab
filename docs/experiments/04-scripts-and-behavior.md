# Experiment 04 — Scripts e comportamento

## 🎯 Objetivo

Investigar como um Script pode ser associado a um Node e executar lógica durante a execução de uma Scene.

## 🧪 Experimento

Foi criado um Script GDScript (`main.gd`) e associado ao `Node2D` raiz da Scene `main`.

A Godot criou inicialmente duas funções no Script:

* `_ready()`
* `_process(delta)`

Primeiro, `_ready()` foi utilizado para exibir uma mensagem no terminal:

```gdscript
func _ready() -> void:
    print("O Node entrou na Scene Tree!")
```

A mensagem foi exibida uma única vez ao executar a Scene.

Em seguida, `_process()` foi utilizado para exibir uma mensagem repetidamente:

```gdscript
func _process(delta: float) -> void:
    print("processando")
```

A mensagem foi exibida várias vezes enquanto a Scene permanecia em execução.

Por fim, o Script foi utilizado para alterar a posição do `Node2D`:

```gdscript
func _process(delta: float) -> void:
    position.x += 1
```

## 👀 Observações

* O Script foi associado ao `Node2D` sem se tornar um Node filho na Scene.
* O arquivo criado foi `main.gd`.
* O Script utiliza `extends Node2D`.
* `_ready()` foi executado uma vez quando o Node entrou na Scene Tree.
* `_process()` foi executado repetidamente durante a execução.
* Alterar `position.x` dentro de `_process()` modificou a posição do `Node2D`.
* As duas instâncias filhas acompanharam o deslocamento do `Node2D` pai.

## 💡 Descoberta

Um Script pode adicionar comportamento a um Node durante a execução da Scene.

O comportamento observado pode ser representado como:

```text
Node
  ↓
Script
  ↓
função executada durante a execução
  ↓
alteração de propriedade
  ↓
mudança observável na Scene
```

O experimento também confirmou uma relação observada anteriormente:

```text
Parent muda de posição
        ↓
Children acompanham
```

Neste caso, a alteração da posição do parent foi realizada pelo Script durante a execução.

## ⚠️ Limite da descoberta

O experimento demonstrou que `_process()` é executado repetidamente e pode modificar propriedades do Node.

Ainda não foi investigado o significado de `delta` nem a relação entre a execução por frames e o controle de velocidade de um objeto.

Esses conceitos serão investigados posteriormente.

## ✅ Resultado

O experimento permitiu compreender experimentalmente que:

* Nodes podem possuir Scripts associados;
* Scripts podem ser escritos em GDScript;
* um Script pode herdar do tipo do Node ao qual está associado;
* `_ready()` permite executar lógica quando o Node entra na Scene Tree;
* `_process()` permite executar lógica repetidamente durante a execução;
* o Script pode alterar propriedades do Node;
* alterações no parent podem afetar seus children.

## 📌 Próximo experimento

Investigar o parâmetro `delta` recebido por `_process()` e compreender sua relação com o tempo e o movimento.
