README for prolog assignment 
					by Anurag Prakash(2013A7PS061P)
					 and Pratik S.(2013A7PS057P)
					 (Section 2)


Topic for our assignment :- Codify Article 1 section 6-8 of the U.S. constitution.

Predicates :-
	
	salary(ToBePayed,ToPay,WhoDecides,HowMuch).

		ToBePayed :- Entered by user.
					 Tells us who is to be payed i.e. whose salary are we talking about.
		ToPay     :- Output.
					 Tells us who will provide the required money to fulfill the above's salary requirements.
		WhoDecides:- Output.
					 Tells us who decides how much the salary will be.
		HowMuch   :- Output.
					 Tells us how much is the salary of the person going to be.

		Example   :- (input)
					 ?- salary('Barack Obama',ToPay,WhoDecides,HowMuch).

					 (output)
					 ToPay = 'U.S. Treasury',
					 WhoDecides = 'Themselves',
					 HowMuch = 'Whatever was decided in last term' ;
					 false.


	arrest(Who,Reason,WherePersonIs,Conclusion).

		Who 	  :- Entered by user.(optional)
					 Who is the person to be arrested.
					 If not entered then it prints out how all can different citizens of the U.S. be arrested.
		Reason    :- Entered by user.(optional)
					 Reason for arresting that person.
					 If not entered then it prints out how all can a congressman be arrested.	 
		WherePersonIs :- Entered by user.(optional)
					     Where that person was when he committed the crime.
					     If not entered then it prints out where all the congressman can be to be immune to civil crime arrests.
		Conclusion:- Output.
					 Can that person be arrested.

		Example   :- (input)
					 ?- arrest('Senator','Collusion','Park',Conclusion).

					 (output)
					 Conclusion = 'Yes' ;
					 false.

		** all optional variables require that the variables before them be given a value else it does not matter whether they are given a value. They are considered empty.


	job(Who,Where,When,PayIncBool,CanGetJob).

		Who   	  :- Entered by the user.
					 This tells us who is being considered for the job.
		Where     :- Entered by the user.
					 This gives which job, i.e what kind of office. This is most meaningfully entered by the user.
		When 	  :- This tells us when the person(especially senator) is seeking the job.i.e 'outside their term' or 'during term'. If all other parameters are specified 				 this may be left as a variable while querying.
		PayIncBool:- This takes value *true* or *false* as according to if pay has increased in this term or not.
		CanGetJob :- Output.
					 This tells us if 'Who' can get the job.

		Here,
			while querying one may enter the values of 1 or more variables as atoms and expect the interpreter to give us the values of other variables to satisfy the query
			this query tells us if under different conditions the person specified by "Who" can get the job at office "Where" at time "When" if pay has increased in this term accordind to "PayIncBool" (true/false).

			for eg. if i want to know if *senator* can get a job at *civiloffice* at time * 'during term' and there has not been pay increase i.e *false* then we may query:-

			?- job(senator,civiloffice,'during term',false,X). 

			we get the result:-
			X = 'No they cant get this job'

			We can use the predicate to ask more powerful questions of the form where all can a senator get a job and where all he cant ,specifying all but the second and last variables in the query as follows:-

			job(senator,Y,'during term',false,X).

			we get the result:-
				Y = legoffice,
				X = 'Yes they can get this job' ;
				Y = senateoffice,
				X = 'Yes they can get this job' ;
				Y = civiloffice,
				X = 'No they cant get this job' ;
				Y = court,
				X = 'No they cant get this job' ;


	bill(Type,WorkofPresident,Time,PossibleOrigin,WorkofHousesBefore,WorkofHouseAfter,Conclusion).

		Type 	  :- Entered by user.(optional)
					 What is the type of bill.
					 If not entered then it prints out how all the types of bills can become law.
		WorkofPresident:- Entered by user.(optional)
					 What does the president do when he recieves the bill.
					 If not entered then it prints out the work of the president for different types of bills.
		Time	  :- Entered by user.(optional)
					 How much time has passed since the bill was given to the president.
					 If not entered then it tells us all the things the president can do with the bill.
		PossibleOrigin:-Output.
					 Where can the bill originate from.
		WorkofHousesBefore:- Output.
							 What do the houses have to do before sending the bill to the president.
		WorkofHouseAfter:- Output.
						   What do the houses have to do if the president vetoes the bill.
		Conclusion:- Output.
					 Tells us whether a bill becomes a law.
		Example   :- (input)
					 ?- bill('Resolution','Veto',5,Origin,WorkBefore,WorkAfter,Conclusion).

					 (output)
					 Origin = ['House of Representatives', 'Senate'],
					 WorkBefore = 'Pass the Bill',
					 WorkAfter = 'The stand of the president does not matter',
					 Conclusion = 'If 2/3rd of both houses pass it then Bill becomes Law irrespective of signature of the president' ;
					 false.

		** all optional variables require that the variables before them be given a value else it does not matter whether they are given a value. They are considered empty.


	hasPower(Who,What,HasPowerBool).

		Who  	  :- Tells us who's power are we talking about(*congress*,*judiciary*,*executive*).
        			 (optional).if querying is done by leaving it as a variable,gives who's power is being referred to in "What")
 		What 	  :- Tells us what power is being spoken of, it can be given a value from the 3 power lists in the code,and it can tell us "Who" has this power or if the 			   body input in "Who" has this power using "HasPowerBool".
					 Leaving it as a variable will list all powers of "Who".
		HasPowerBool:- Tells us if "Who" has power "What".

		Example	  :- (input)
					 ?- hasPower(congress,'To borrow Money on the credit of the United States;',HasPowerBool).

					 (output)
					 HasPowerBool = 'yes'


	congressfundingOperation(Opname,DurationYrs).

		Opname	  :- Tells us what kind of operation this is.
					 If Left as a variable while querying,will give us the operations which are possible to be funded by the congress for the duration of *DurationYrs*
		DurationYrs:- The duration for which the operation can be funded in yrs.
					  If left as a variable, will tell us for how long "Opname" can be funded.

		Example	  :- (input)
					 ?- congressfundingOperation('weapons research',DurationYrs).

					 (output)
					 DurationYrs = 'Military operations like these can be funded for a duration of only 2 yrs or less'


	generateRevenueMethod(RevMethod).

		RevMethod :- This takes a particular method of generating revenue as input and tells if the congress can indeed generate revenue in this way.
	   				 If it is left as a variable, it will list the various methods of revenue generation that are in its power as afforded by the constitution.

	   	Example   :- (input)
	   				 ?- generateRevenueMethod(R).

	   				 (output)
	   				 Method = 'collect taxes' ;
  					 Method = 'borrow on credit of US' ;
					 Method = 'mint money' ;
					 Method = 'collect duties and excises' ;
					 Method = 'regulate interstate trade' ;
