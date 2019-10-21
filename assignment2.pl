/*section 6*/

repList(['Senator','Senators','Representatives','Representative','MP','Member of Parliament','Members of Parliament','Congressmen','Joe Biden','Patrick Leahy','Richard Shelby','Lisa Markowski','Hilary Clinton','Barack Obama']).

avgWorkerList(['Anurag Prakash','Computer Scientist','Teacher','Father','Student']).

arrestReasonsCriminal(['Treason','Murder','Breach of Peace','Theft','Felony','Arson']).
arrestReasonCivil(['Embezzlement','Collusion','Saying something in court','Doing something as a Representative']).

arrestLocationA(['In Session','Going to session','Coming from session','Outside country']).

arrestLocationB(['House','Park','Hospital','Jail','Street','Market','Movie Theatre','Restaurant']).

search(Item,[Item|_]).
search(Item,[_|Tail]):-search(Item,Tail).

salary(ToBePayed,ToPay,WhoDecides,HowMuch) :-
	(
          repList(RepList),
          search(ToBePayed,RepList),
	  ToPay = 'U.S. Treasury',
          WhoDecides = 'Themselves',
          HowMuch = 'Whatever was decided in last term'
         );
	(
	  avgWorkerList(AvgWorkerList),
	  search(ToBePayed,AvgWorkerList),
	  ToPay = 'Their employer',
	  WhoDecides = 'As decided in their contract',
	  HowMuch = 'Whatever the contract between them and their employer says' )
	.

arrest(Who,Reason,WherePersonIs,Conclusion):-
	(
           \+(atom(Who)),
	   Conclusion = 'A Congressman can be arrested for Criminal offences. He cannot be arrested for Civil crimes committed during session as a legislature but can be arrested if not committed during session. Any other regular citizen can be arrested for all crimes anywhere.'
        );
	(
           atom(Who),
           repList(RepList),
           search(Who,RepList),
          (
	   (
	       \+(atom(Reason)),
	       Conclusion = 'A Congressman can be arrested for Criminal offences. He cannot be arrested for Civil crimes committed during session as a legislature but can be arrested if not committed during session.'
	   );
	   (
	       atom(Reason),
	       arrestReasonCivil(CrimeList),
	       search(Reason,CrimeList),
	       \+(atom(WherePersonIs)),
	       Conclusion = 'A Congressman cannot be arrested for Civil crimes committed during session as a legislature but can be arrested if not committed during session.'
	   );
           (
	       atom(Reason),
	       arrestReasonsCriminal(CrimeList),
               search(Reason,CrimeList),
	       Conclusion = 'Yes'
	   );
	   (
	       atom(Reason),
	       atom(WherePersonIs),
	       arrestReasonCivil(CrimeList),
	       search(Reason,CrimeList),
	       arrestLocationA(Loc),
	       search(WherePersonIs,Loc),
	       Conclusion = 'No'
	   );
	   (
	       atom(Reason),
	       atom(WherePersonIs),
	       arrestReasonCivil(CrimeList),
	       search(Reason,CrimeList),
	       arrestLocationB(Loc),
	       search(WherePersonIs,Loc),
	       Conclusion = 'Yes'
	   )
	  )
	);
	(
	    atom(Who),
	  \+((
	    repList(RepList),
            search(Who,RepList)
	   )),
	    Conclusion = 'Yes'
	).

who1([senator,representative,joe_biden,patrick_leahy,richard_shelby,lisa_murkowski]).
who2([me,avgworker,sam]).
where1([civiloffice,court]).
where2([legoffice,senateoffice]).

job(Who,Where,_,_,'Yes they can get this job'):-who2(X),search(Who,X),((where1(Y),search(Where,Y));(where2(Y),search(Where,Y))).


job(Who,Where,'outside their term',_,'Yes they can get this job'):-((who1(Y),search(Who,Y));(who2(Y),search(Who,Y))),((where1(Y),search(Where,Y));(where2(Y),search(Where,Y))).


job(Who,Where,_,false,'Yes they can get this job'):-who1(X),search(Who,X),
						       where2(Y),search(Where,Y).
job(Who,Where,'during term',_,'No they cant get this job'):-who1(X),search(Who,X),
	             where1(Y),search(Where,Y).

job(Who,Where,'during term',true,'No they cant get this job'):-who1(X),search(Who,X),
	             where2(Y),search(Where,Y).

/* section 7 */

typesofBills(['Revenue','Non-Revenue','Resolution']).

presidentActions(['Sign','Not Sign','Veto']).

houseList(['House of Representatives','Senate']).

bill(Type,WorkofPresident,Time,PossibleOrigin,WorkofHousesBefore,WorkofHousesAfter,Conclusion) :-
	(
	   \+(atom(Type)),
             Conclusion = 'There are three kinds of bills :- Revenue, Non-Revenue, Resolution.Revenue bills only originate in the House of Representatives. The senate can only suggest changes but it has to ultimately pass the bill.Non-Revenue bills can originate in either house.They are passed to the president who is given 10 days to Sign it or Veto it. If he signs it then the bill becomes a law. If he does nothing within 10 days then also the bill becomes a law. If he Vetoes it then he returns it the house where the bill originated with his recommended changes which put the (changed)bill again to vote. If 2/3rd of Representatives vote in its favour then it goes to the next house. If the other house also has 2/3rd of its Representatives in favour then the bill becomes a law.Resolutions are special bills where if the bill gets more than 2/3rd of majority in both houses then it becomes law without the need of the president.'
	);
	(
          atom(Type),
          typesofBills(BillList),
	  search(Type,BillList),
          (
	      (
	          \+(atom(WorkofPresident)),
	            (
			(
			   Type == 'Revenue',
			   Conclusion = 'Revenue bills only originate in the House of Representatives. The senate can only suggest changes but it has to ultimately pass the bill.They are passed to the president who is given 10 days to Sign it or Veto it. If he signs it then the bill becomes a law. If he does nothing within 10 days then also the bill becomes a law. If he Vetoes it then he returns it the house where the bill originated with his recommended changes which put the (changed)bill again to vote. If 2/3rd of Representatives vote in its favour then it goes to the next house. If the other house also has 2/3rd of its Representatives in favour then the bill becomes a law.'
		        );
			(
			    Type == 'Non-Revenue',
			    Conclusion = 'Non-Revenue bills can originate in either house.They are passed to the president who is given 10 days to Sign it or Veto it. If he signs it then the bill becomes a law. If he does nothing within 10 days then also the bill becomes a law. If he Vetoes it then he returns it the house where the bill originated with his recommended changes which put the (changed)bill again to vote. If 2/3rd of Representatives vote in its favour then it goes to the next house. If the other house also has 2/3rd of its Representatives in favour then the bill becomes a law.'
			);
			(
			    Type == 'Resolution',
			    Conclusion = 'Resolutions are special bills where if the bill gets more than 2/3rd of majority in both houses then it becomes law without the need of the president.'
			)
		    )
	      );
	      (
		  atom(WorkofPresident),
	          presidentActions(Actions),
	          search(WorkofPresident,Actions),
	          (
		     (
	                (
		           (
		               Type == 'Revenue',
		               houseList([X|_]),
		               PossibleOrigin = X
		           );
		           (
			       Type == 'Non-Revenue',
			       houseList(T),
			       PossibleOrigin = T
		           )
	                ),
		        WorkofHousesBefore = 'Pass the Bill',
		        (
		           (
			       \+(integer(Time)),
				(
				     Conclusion ='The president is given 10 days to Sign the bill or Veto it. If he signs it then the bill becomes a law. If he does nothing within 10 days then also the bill becomes a law. If he Vetoes it then he returns it the house where the bill originated with his recommended changes which put the (changed)bill again to vote. If 2/3rd of Representatives vote in its favour then it goes to the next house. If the other house also has 2/3rd of its Representatives in favour then the bill becomes a law.'
				)

			   );
			   (
			       integer(Time),
		               (
		                   WorkofPresident == 'Sign';
		                  (WorkofPresident == 'Not Sign',Time > 10)
		               ),
		               Conclusion = 'Bill becomes Law'
	                   );
		           (
			       integer(Time),
			      (WorkofPresident == 'Not Sign',Time =< 10),
			      Conclusion = 'Wait for President to sign or veto. (Special Case: In case of adjournement of Congress within 10 days President has pocket Veto i. e. he may not sign the bill and it would not become a law'
		           );
		           (
			       integer(Time),
			       (WorkofPresident == 'Veto',Time =< 10),
			       WorkofHousesAfter = 'Reconsider changes and revote on Bill',
			       Conclusion = 'If 2/3rd of both houses pass it then Bill becomes Law irrespective of signature of the president'
	                   );
			   (
			       integer(Time),
			       (WorkofPresident == 'Veto',Time > 10),
			       Conclusion = 'Bill becomes Law'

			   )
		        )
	            );
	            (
		        Type == 'Resolution',
		        houseList(T),
		        PossibleOrigin = T,
		        WorkofHousesBefore = 'Pass the Bill',
		        WorkofHousesAfter = 'The stand of the president does not matter',
		        Conclusion = 'If 2/3rd of both houses pass it then Bill becomes Law irrespective of signature of the president'
	            )
		 )
	     );
             (
		   atom(WorkofPresident),
	         \+((
	               presidentActions(Actions),
	               search(WorkofPresident,Actions)
	           )),
		  (
                    (
		        Type == 'Resolution',
		        houseList(T),
		        PossibleOrigin = T,
		        WorkofHousesBefore = 'Pass the Bill',
		        WorkofHousesAfter = 'The stand of the president does not matter',
		        Conclusion = 'If 2/3rd of both houses pass it then Bill becomes Law irrespective of signature of the president'
	            );
	            (
		        \+( Type == 'Resolution'),
	                Conclusion = 'That is not a valid president action'
	            )
		  )
	     )
	  )
	);
	(
	    atom(Type),
	    \+((
	       typesofBills(BillList),
	       search(Type,BillList)
	     )),
	    Conclusion = 'Not a valid Bill type'
	).


/* section 8 */

power1(['To lay and collect Taxes, Duties, Imposts and Excises, to pay the Debts and provide for the common Defence and general Welfare of the United States; but all Duties, Imposts and Excises shall be uniform throughout the United States;',
	'To borrow Money on the credit of the United States;',
	'To regulate Commerce with foreign Nations, and among the several States, and with the Indian Tribes;',
	'To establish an uniform Rule of Naturalization, and uniform Laws on the subject of Bankruptcies throughout the United States;',
	'To coin Money, regulate the Value thereof, and of foreign Coin, and fix the Standard of Weights and Measures;',
	'To provide for the Punishment of counterfeiting the Securities and current Coin of the United States;',
	'To establish Post Offices and post Roads;',
	'To promote the Progress of Science and useful Arts, by securing for limited Times to Authors and Inventors the exclusive Right to their respective Writings and Discoveries;',
	'To constitute Tribunals inferior to the supreme Court;',
	'To define and punish Piracies and Felonies committed on the high Seas, and Offences against the Law of Nations;',
	'To declare War, grant Letters of Marque and Reprisal, and make Rules concerning Captures on Land and Water;',
	'To raise and support Armies, but no Appropriation of Money to that Use shall be for a longer Term than two Years;',
	'To provide and maintain a Navy;',
	'To make Rules for the Government and Regulation of the land and naval Forces;',
	'To provide for calling forth the Militia to execute the Laws of the Union, suppress Insurrections and repel Invasions;',
	'To provide for organizing, arming, and disciplining, the Militia, and for governing such Part of them as may be employed in the Service of the United States, reserving to the States respectively, the Appointment of the Officers, and the Authority of training the Militia according to the discipline prescribed by Congress;',
	'To exercise exclusive Legislation in all Cases whatsoever, over such District (not exceeding ten Miles square) as may, by Cession of particular States, and the Acceptance of Congress, become the Seat of the Government of the United States, and to exercise like Authority over all Places purchased by the Consent of the Legislature of the State in which the Same shall be, for the Erection of Forts, Magazines, Arsenals, dock-Yards, and other needful Buildings;',
	'To make all Laws which shall be necessary and proper for carrying into Execution the foregoing Powers, and all other Powers vested by this Constitution in the Government of the United States, or in any Department or Officer thereof;']).

power2(['To strike down if necessary, a law as unconstitutional;',
	 'To determine how Congress meant the law to apply in disputes;',
	'To Determine how laws should be interpreted;']).

power3(['To wage war at the direction of Congress',
	'To grant pardons to convicted persons, except in cases of impeachment;',
	'To enforce the proper implementation of laws passed by the congress;']).



hasPower(congress,What,yes):-power1(Powers),search(What,Powers).
hasPower(congress,What,'no these powers are vested with the judiciary'):-power2(Powers),search(What,Powers).
hasPower(congress,What,'no these powers are vested with the executive'):-power3(Powers),search(What,Powers).

hasPower(judiciary,What,yes):-power2(Powers),search(What,Powers).
hasPower(judiciary,What,'no these powers are vested with the congress'):-power1(Powers),search(What,Powers).
hasPower(judiciary,What,'no these powers are vested with the executive'):-power3(Powers),search(What,Powers).

hasPower(executive,What,yes):-power2(Powers),search(What,Powers).
hasPower(executive,What,'no these powers are vested with the congress'):-power1(Powers),search(What,Powers).
hasPower(executive,What,'no these powers are vested with the judiciary'):-power2(Powers),search(What,Powers).


oplist1(['military operation','weapons research','remote surveilance','bio Warfare']).
oplist2(['Dam Project','civil project','urbanisation','medical research']).

congressfundingOperation(Opname,DurationYrs):-oplist1(Oplist),search(Opname,Oplist),integer(DurationYrs),2>=DurationYrs.
congressfundingOperation(Opname,DurationYrs):-oplist2(Oplist),search(Opname,Oplist),integer(DurationYrs).
congressfundingOperation(Opname,'non military operations can be funded for any period of time'):-oplist2(Oplist),search(Opname,Oplist).
congressfundingOperation(Opname,'Military operations like these can be funded for a duration of only 2 yrs or less'):-oplist1(Oplist),search(Opname,Oplist).


revList(['collect taxes','borrow on credit of US','mint money','collect duties and excises','regulate interstate trade']).

generateRevenueMethod(RevMethod):-revList(RevList),search(RevMethod,RevList).













