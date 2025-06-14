# Relatório de Comparação de Algoritmos

Este relatório descreve a comparação entre três técnicas de otimização disponíveis no repositório:

- **Algoritmo Genético (GA)** implementado em `GA.R`;
- **Particle Swarm Optimization (PSO)** implementado em `pso.R`;
- **Glowworm Swarm Optimization (GSO)** implementado em `glowworm.R`.

O objetivo é verificar o desempenho de cada método ao minimizar a função de Rosenbrock em duas dimensões.

## Metodologia

O script `compare_algorithms.R` executa cada algoritmo dez vezes utilizando as mesmas configurações básicas para garantir justiça na comparação:

- Tamanho da população: 30 indivíduos;
- Número máximo de iterações: 200;
- Limites das variáveis: \[-5, 5\] em cada dimensão;
- Semente aleatória fixa (`set.seed(123)`).

Após cada execução é registrada a melhor avaliação de cada algoritmo. No final são calculados, para cada método, o valor mínimo, a média e o desvio padrão das melhores soluções obtidas.

O trecho central do script responsável pelo cálculo é:

```r
for(i in 1:execs){
  ga.res <- GA(Rosenbrock, lb, ub, pop.size = pop.size, dimension = dim,
               max.it = it, pc = 0.6, pm = 0.01, sel = 1, elitism = TRUE)
  best.ga[i] <- min(ga.res$fit)

  pso.res <- pso(Rosenbrock, lb, ub, pop.size = pop.size, dimension = dim,
                 max.it = it)
  best.pso[i] <- pso.res$best.fit

  gso.res <- glowworm(Rosenbrock, lb, ub, pop.size = pop.size, dimension = dim,
                      max.it = it)
  best.gso[i] <- min(gso.res$fit)
}
```

## Execução

A execução do script requer o interpretador `Rscript`. No ambiente atual a tentativa de execução falhou:

```
$ Rscript compare_algorithms.R
bash: Rscript: command not found
```

Portanto não foi possível obter os resultados numéricos nesta análise.

## Conclusão

O repositório fornece implementações básicas de GA, PSO e GSO. O script `compare_algorithms.R` permite rodar os três algoritmos sob as mesmas condições para comparar desempenho na função de Rosenbrock. Contudo, a ausência do `Rscript` no ambiente impede a execução e a coleta de resultados. Para reproduzir a comparação recomenda-se instalar o ambiente R e então executar o script.
