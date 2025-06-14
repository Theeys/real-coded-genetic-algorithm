# Compare GA, PSO, and Glowworm algorithms on Rosenbrock function
source('GA.R')
source('init.population.R')
source('crossover.R')
source('mutation.R')
source('selection.R')
source('pso.R')
source('glowworm.R')
source('Benchmarks.R')

set.seed(123)
it <- 200
pop.size <- 30
dim <- 2
lb <- rep(-5, dim)
ub <- rep(5, dim)
execs <- 10

best.ga <- numeric(execs)
best.pso <- numeric(execs)
best.gso <- numeric(execs)

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

res <- rbind(
  GA = c(min(best.ga), mean(best.ga), sd(best.ga)),
  PSO = c(min(best.pso), mean(best.pso), sd(best.pso)),
  Glowworm = c(min(best.gso), mean(best.gso), sd(best.gso))
)
colnames(res) <- c('min', 'mean', 'sd')

print(res)
if(exists('View')) View(res)

