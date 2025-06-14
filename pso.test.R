source('pso.R')
source('Benchmarks.R')

set.seed(123)
it <- 200
pop.size <- 30
dim <- 2
lb <- rep(-5, dim)
ub <- rep(5, dim)

res <- pso(Rosenbrock, lb, ub, pop.size = pop.size, dimension = dim, max.it = it)
print(res$best.fit)
