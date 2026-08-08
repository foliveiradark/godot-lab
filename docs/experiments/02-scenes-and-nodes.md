# Experiment 02 — Scenes e Nodes

## 🎯 Objetivo

Investigar como uma Scene é estruturada na Godot e compreender, por meio de experimentação, a relação entre Nodes e sua hierarquia.

## 🧪 Experimento

Foi criada uma estrutura simples contendo:

```text
Node2D
└── Label
```

O `Node2D` foi utilizado como elemento principal da cena e um `Label` foi adicionado como seu filho.

Foram realizadas alterações de posição no `Node2D` e no `Label` para observar o comportamento da hierarquia.

## 👀 Observações

### Node2D

Ao alterar as propriedades `Position X` e `Position Y` do `Node2D`, sua posição na área de trabalho da Scene foi alterada.

O `Label`, por estar dentro do `Node2D` na hierarquia, acompanhou esse deslocamento.

### Label

Ao alterar a posição do `Label`, somente o `Label` foi movimentado.

O `Node2D` permaneceu em sua posição original.

O comportamento observado foi:

```text
Mover o Parent
    ↓
Parent muda de posição
    ↓
Child acompanha
```

Enquanto:

```text
Mover o Child
    ↓
Child muda de posição
    ↓
Parent permanece
```

## 💡 Descoberta

A hierarquia de Nodes estabelece uma relação de **parent/child**.

Nesse experimento:

```text
Node2D
└── Label
```

o `Node2D` é o **parent** e o `Label` é o **child**.

Foi observado que o movimento do parent desloca também o child, enquanto o movimento do child não altera a posição do parent.

Isso demonstra que, neste contexto, a hierarquia da Scene possui efeito sobre o comportamento espacial dos Nodes.

## ⚠️ Observação sobre o Label

Ao acessar as propriedades de `Layout` do `Label`, a Godot apresentou um aviso informando que o Node não possuía um `Control` como parent.

Esse comportamento foi mantido durante o experimento.

A mensagem serviu como evidência de que diferentes tipos de Nodes possuem mecanismos e responsabilidades diferentes.

A investigação detalhada dessa diferença será realizada em experimentos posteriores.

## 🧠 Relação com programação

Durante o experimento surgiu uma possível relação com o conceito de **composição** estudado anteriormente em programação.

Entretanto, a hierarquia de Scene observada na Godot não deve ser confundida diretamente com **herança de classes**.

A relação:

```text
Node2D
└── Label
```

representa uma relação estrutural entre elementos da Scene.

Já uma relação de herança representa uma relação entre tipos/classes.

Essa distinção será investigada posteriormente quando começarmos a utilizar GDScript.

## ✅ Resultado

O experimento permitiu compreender experimentalmente que:

* uma Scene possui uma estrutura hierárquica de Nodes;
* Nodes podem possuir outros Nodes como filhos;
* existe uma relação parent/child;
* o movimento do parent afeta seus children;
* o child pode ser movimentado independentemente do parent;
* a hierarquia da Scene pode afetar o comportamento espacial dos elementos.

## 📌 Próximo experimento

Investigar como uma Scene pode ser **salva, reutilizada e instanciada** dentro de outra Scene.

A questão que orientará o próximo experimento será:

> **Uma Scene pode funcionar como uma unidade reutilizável?**
