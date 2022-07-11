# Inexpensive_and_Informative_Greedy_Backward_algorithm
Inexpensive and Informative Greedy Backward algorithm (IIGB)

IIGB is a backward greedy algorithm that iteratively solves a sensor placement design problem. The problem is to minimize cumulative Kullback-Leibler divergence (CRKL). The main concept behind the proposed algorithm (IIGB) is to start with a full sensor placement that corresponds to the best case scenario when all variables in the process are measured with the maximum possible sensors. Then, IIGB recursively eliminates one sensor at each iteration based on some criteria. The algorithm stops when the cost constraint is met. IIGB uses two parallel criteria where a sensor is eliminated in an iteration.

In the current code, IIGB is demonstrated using ammonia reliability expression. Similarly, reliability expression for steam metering can be generated using a sum of [disjoint product approach](https://github.com/prakashoms/Sum_of_Disjoint_Product) as mentioned in the following paper.

### For details about the IIGB algorithm, please refer to the following journal paper.
Om Prakash and Mani Bhushan, **Cumulative Residual Kullback-Leibler Divergence Based Sensor Placement Using Reliability Criteria**, Computers and Chemical Engineering (2022), [[Preprint]](https://www.researchgate.net/publication/361864977_Cumulative_Residual_Kullback-Leibler_Divergence_Based_Sensor_Placement_Using_Reliability_Criteria) [[Publisher Link]](https://doi.org/10.1016/j.compchemeng.2022.107908).
