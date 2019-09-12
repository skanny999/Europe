# Europe
Europe test app


### Feedback

1. There is almost no use of abstraction and dependency injection: most components have hidden dependency on other components. This decrease testability and increase tightly coupling. 
2. Unit tests for VC are also missing. CountryErrorTest is not really needed (it is testing a Foundation feature). 
3. The CoreData entity (Model) knows about API response keys, which shouldn't happen. It is also fetching data from the network, which shouldn't happen too. (no clear distinction of responsibilities) 
DataProvider access DataProcessor, which in turn access DataProvider again, creating a cycle of dependencies. Also, these accesses happens inside CoreData context as well. (again, no clear definition of responsibilities) 


