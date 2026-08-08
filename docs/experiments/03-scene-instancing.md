# Experiment 03 — Scene Instancing

## 🎯 Objetivo

Investigar como uma Scene pode ser reutilizada dentro de outra Scene e como suas instâncias se comportam.

## 🧪 Experimento

Foi criada `reusable_scene.tscn`:

Node2D
└── Label

A Scene foi instanciada duas vezes em `main.tscn`.

## 👀 Observações

### Alteração da Scene original

O texto do `Label` foi alterado em `reusable_scene.tscn`.

Resultado:

→ as duas instâncias foram atualizadas.

### Alteração da instância

A posição de uma instância foi alterada.

Resultado:

→ somente aquela instância mudou de posição.

### Editable Children

Os filhos de uma instância foram habilitados para edição.

O texto do `Label` dessa instância foi alterado.

Resultado:

→ somente aquela instância foi modificada.

## 💡 Descoberta

Uma Scene pode funcionar como uma unidade reutilizável.

Suas instâncias compartilham a definição da Scene original, mas podem possuir determinadas configurações próprias.

Scene:

reusable_scene.tscn
       ↓
   ┌───┴───┐
   ↓       ↓
Instância A  Instância B

Alterações na Scene original → afetam as instâncias.

Alterações específicas na instância → podem afetar somente aquela ocorrência.

## 🧠 Conclusão

O experimento demonstrou na prática a diferença entre **Scene** e **Instance**.

A Scene define uma unidade reutilizável, enquanto a instância representa o uso dessa unidade dentro de outra Scene.

## 📌 Próximo experimento

Investigar como adicionar comportamento aos Nodes utilizando Scripts e GDScript.