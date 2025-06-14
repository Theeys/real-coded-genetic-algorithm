# Particle Swarm Optimization implementation in R

pso <- function(func, lb, ub, pop.size = 20, dimension = 2, max.it = 100,
                w = 0.7, c1 = 1.5, c2 = 1.5){
  pos <- matrix(runif(pop.size * dimension), nrow = pop.size)
  pos <- lb + pos * (ub - lb)
  vmax <- abs(ub - lb)
  vel <- matrix(runif(pop.size * dimension, -vmax, vmax), nrow = pop.size)
  pbest <- pos
  pbest.f <- apply(pos, 1, func)
  gbest.idx <- which.min(pbest.f)
  gbest <- pbest[gbest.idx,]
  gbest.f <- pbest.f[gbest.idx]

  for(t in 1:max.it){
    r1 <- matrix(runif(pop.size * dimension), nrow = pop.size)
    r2 <- matrix(runif(pop.size * dimension), nrow = pop.size)
    vel <- w * vel + c1 * r1 * (pbest - pos) +
           c2 * r2 * (matrix(gbest, nrow = pop.size, ncol = dimension,
                             byrow = TRUE) - pos)
    vel <- pmin(pmax(vel, -vmax), vmax)
    pos <- pos + vel
    pos[pos < lb] <- lb[which(pos < lb, arr.ind = TRUE)[,2]]
    pos[pos > ub] <- ub[which(pos > ub, arr.ind = TRUE)[,2]]
    fit <- apply(pos, 1, func)

    improve <- fit < pbest.f
    pbest[improve,] <- pos[improve,]
    pbest.f[improve] <- fit[improve]

    if(min(pbest.f) < gbest.f){
      gbest.idx <- which.min(pbest.f)
      gbest <- pbest[gbest.idx,]
      gbest.f <- pbest.f[gbest.idx]
    }
  }
  return(list(pop = pos, fit = fit, best = gbest, best.fit = gbest.f))
}

