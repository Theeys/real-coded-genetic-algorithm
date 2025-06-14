# Glowworm Swarm Optimization implementation in R

glowworm <- function(func, lb, ub, pop.size = 20, dimension = 2, max.it = 100,
                     step.size = 0.03, rho = 0.4, gamma = 0.6,
                     beta = 0.08, nt = 5, rs = 1){
  # initialize population
  pop <- matrix(runif(pop.size * dimension), nrow = pop.size)
  pop <- lb + pop * (ub - lb)
  luciferin <- rep(5, pop.size)
  r <- rep(rs/2, pop.size)
  fitness <- apply(pop, 1, func)

  normalize <- function(x) x / sqrt(sum(x^2))

  for(t in 1:max.it){
    luciferin <- (1 - rho) * luciferin + gamma * (1/(1 + fitness))
    for(i in 1:pop.size){
      d <- sqrt(rowSums((t(pop) - pop[i,])^2))
      neigh <- which(d <= r[i] & luciferin > luciferin[i])
      if(length(neigh) > 0){
        probs <- luciferin[neigh] - luciferin[i]
        probs <- probs / sum(probs)
        j <- sample(neigh, 1, prob = probs)
        direction <- pop[j,] - pop[i,]
        pop[i,] <- pop[i,] + step.size * normalize(direction)
      }
      r[i] <- min(rs, max(0, r[i] + beta * (nt - length(neigh))))
    }
    pop[pop < lb] <- lb[which(pop < lb, arr.ind = TRUE)[,2]]
    pop[pop > ub] <- ub[which(pop > ub, arr.ind = TRUE)[,2]]
    fitness <- apply(pop, 1, func)
  }
  return(list(pop = pop, fit = fitness))
}

