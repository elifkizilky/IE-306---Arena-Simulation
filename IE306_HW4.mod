
0$            CREATE,        1:NORMAL(5,1):NEXT(2$);                            Engineering students with interarrival times Normal(5,1)

2$            ASSIGN:        Student_type=1:
                             Service_time=UNIFORM(2,7);                         Eng. students service time with Uniform(2,7)
4$            QUEUE,         server_queue:MARK(TimeIn);
5$            SEIZE,         1,Other:
                             Food_server,1:NEXT(19$);

19$           TALLY:         Time Spent in the First Queue,INTERVAL(TimeIn),1;  Time spent in the first queue
6$            DELAY:         Service_time,Student_type,Other:NEXT(7$);

7$            RELEASE:       food_server,1;
queue2        QUEUE,         payment_queue;
8$            SEIZE,         1,Other:
                             cashier,1:NEXT(9$);

9$            BRANCH,        1:
                             With,0.6,credit_card,Yes:
                             With,0.4,cash,Yes;
credit_card   DELAY:         UNIFORM(1,2),Student_type+2,Other:NEXT(10$);       Credit card payment

10$           RELEASE:       cashier,1;
11$           BRANCH,        1:
                             With,0.25,forget,Yes:
                             With,0.75,leave,Yes;
forget        COUNT:         Student_type,1;
12$           DELAY:         0.5,,Other:NEXT(queue2);                           the students gets its forgotten drink

leave         DISPOSE:       No;                                                student leaves

cash          DELAY:         UNIFORM(2,6),Student_type+2,Other:NEXT(10$);       cash payment


1$            CREATE,        1:EXPONENTIAL(4):NEXT(3$);                         Social science students with interarrival time exponential(4)

3$            ASSIGN:        Student_type=2:
                             Service_time=EXPONENTIAL(5):NEXT(4$);              Social science students with service time Exponential(5)


13$           CREATE,        1,180:180:NEXT(14$);                               Created for break

14$           ASSIGN:        Service_time=15;
15$           PREEMPT,       1,Other:food_server:NEXT(16$);

16$           DELAY:         Service_time,,Other:NEXT(17$);

17$           RELEASE:       food_server,1;
18$           DISPOSE:       No;





