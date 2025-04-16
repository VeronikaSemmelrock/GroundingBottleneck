
This is the online appendix to the paper **Investigating the Grounding Bottleneck for a Large-Scale Configuration Problem: Existing Tools and Constraint-Aware Guessing** by Veronika B. Semmelrock and Gerhard Friedrich.

  

## The House Configuration Problem (HCP)

Our experiments are performed using an adapted encoding of the HCP. We extend the HCP to include an additional requirement that preserves the numbered order of things and extends it to an order in cabinets. Things and cabinets are numbered, and a thing can be assigned to a particular cabinet only if there is no cabinet with a higher number holding a lower numbered thing.

  

Original sources:

* Friedrich, Gerhard; Ryabokon, Anna; Falkner, Andreas A.; Haselböck, Alois; Schenner, Gottfried; Schreiner, Herwig (2011): (Re)configuration using Answer Set Programming. Proceedings of the IJCAI 2011 Workshop on Configuration (ConfWS 2011).

* Ryabokon, Anna (2015): Knowledge-Based (Re)Configuration of Complex Products and Services. Dissertation. Alpen-Adria-Universität, Klagenfurt.

  
  

## Encodings

  

This online appendix contains encodings of the adapted HCP to be used with the systems evaluated in our experiments.

  

##### clingo, DLV and I-DLV+clasp

The subdirectory `clingo_DLV_I-DLV+clasp` contains the adapted HCP encoding `HCP_encoding.lp` used in combination with the systems clingo, DLV, the combination I-DLV+clasp, incremental-clingo, incremental-DLV and incremental-I-DLV+clasp.

  

##### Alpha

The subdirectory `Alpha` contains the same adapted HCP encoding, with additional domain-specific heuristics for Alpha.

  

##### newground

The subdirectory `newground` contains the adapted HCP encoding with the annotation "#program rules" as a directive to configure the hybrid grounding of newground in the file. Newground is only applied to the rules and constraints below "#program rules". In our experiments, newground is only applied to the constraint `:- cabinetTOthing(C1,T1), cabinetTOthing(C2,T2), C1 < C2, T1 > T2.`, which contains four variables. All other rules in the HCP encoding contain fewer variables in the body. While other hybrid-grounding splits were considered, it was determined that this option provided the best execution time to reach an AS of the HCP for the smallest instance of 50 things.

  

##### ProASP

The `ProASP` subdirectory contains the adapted HCP encoding split into two files, one subject to compilation and one subject to grounding by ProASP (`HCP_encoding_CS-Split_toCompile.asp` and `HCP_encoding_CS-Split_toGround.asp` respectively). ProASP implements mechanisms to merge the grounding and compilation approaches by allowing the user to specify which parts of the encoding should be compiled and which should be grounded. In the search for an optimal application of ProASP, there are six different ways to split an encoding by rule type. After testing each possible encoding split with the HCP encoding, using medium-sized instances of 200 things, it was found that the constraints split gave the optimal performance. In the case of employing ProASP for incremental solving, during the investigation of extending a partial solution of 500 things to a solution of 550 things, the constraints split was again identified as the most efficient, as well as the least memory-consuming approach. The results of these performance tests are outlined in the file `splits_performances.txt` in the same subdirectory. Consequently, when using ProASP in our experiments, all constraints that do not contain aggregates are compiled while the rest are grounded.

  

##### CAG

The subdirectory `CAG` contains the adapted HCP encoding following the constraint-aware guessing (CAG) method, as described in our paper.

  
  

## Binaries and Executables

##### Alpha

The Alpha binaries used for the experiments can be found in the `Alpha` subdirectory as `Alpha.jar` or on the [website](https://git-ainf.aau.at/DynaCon/website/tree/master/supplementary_material/2022_JAIR_Domain-Specific_Heuristics).

Source code and documentation can be found on [GitHub](https://github.com/alpha-asp/Alpha/tree/domspec_heuristics_extended).

  

##### clingo (incl. gringo and clasp)

The clingo system can be obtained as described on the official [website](https://potassco.org/clingo/). In our experiments we used clingo version 5.7.1. This system includes the gringo and clasp tools.

  

##### DLV (incl. I-DLV and WASP)

The DLV system can be obtained as explained on the official [website](https://www.dlvsystem.it/dlvsite/dlv-download/). In our experiments we used version 2.1.2. This system includes the I-DLV and WASP tools.

  

##### newground

Newground can be obtained from[Github](https://github.com/alexl4123/newground/tree/ijcai24-NaGG). Newground NaGG (Newground2, IJCAI24) was used in our experiments.

  

##### ProASP

ProASP is available on[Github](https://github.com/MazzottaG/ProASP). The version of ProASP used in our experiments was downloaded from GitHub on 16. December 2024. Note that ProASP is only supported on Linux.

  

## Problem Instances

  

The file `HCP_instanceGeneration.lp` can be used to generate problem instances of the HCP that contain a consistent solution. The file can be used via the command `gringo HCP_instanceGeneration.lp --const numberOfPersons=5 --const numberOfThingsPerPerson=10 --text > PROBLEM_INSTANCE_FILENAME.lp`. This example command generates a problem instance containing 5 people with 10 things each, including facts for two cabinets and one room per person via the respective domains. The values for numberOfPersons and numberOfThingsPerPerson can be changed in the command to generate different sized instances. The instance is saved in a newly generated file named `PROBLEM_INSTANCE_FILENAME.lp`. In the execution examples below this file is referenced via `{PATH_TO_PROBLEM_INSTANCE}`.

  
  

## Execution

  

##### Alpha

Alpha can be run using the command `java -Xms1G -Xmx31G -jar Alpha/Alpha.jar -i {PATH_TO_PROBLEM_INSTANCE} -n 1`, which sets the initial heap size allocated to the JVM to 1GB, the maximum heap size to 31GB, and tells Alpha to look for the first AS using `-n 1`. Note that the `PATH_TO_PROBLEM_INSTANCE` .lp-file must contain the adapted HCP encoding with domain-specific heuristics for Alpha from the `Alpha` subdirectory (`Alpha/HCP_encoding_withHeuristics_Alpha.lp`), as well as the facts for the problem instance.

  

##### clingo

To test the clingo system, the command `gringo clingo_DLV_I-DLV+clasp/HCP_encoding.lp {PATH_TO_PROBLEM_INSTANCE}` can be used to ground a file, while `clingo clingo_DLV_I-DLV+clasp/HCP_encoding.lp {PATH_TO_PROBLEM_INSTANCE}` can be used to ground and solve in one.

  

##### DLV

DLV can be run using the command `{PATH_TO_DLV} clingo_DLV_I-DLV+clasp/HCP_encoding.lp {PATH_TO_PROBLEM_INSTANCE}`.

  

##### I-DLV+clasp

The combination of I-DLV+clasp can be executed by first grounding a problem instance via I-DLV using the command `{PATH_TO_DLV} --mode=idlv clingo_DLV_I-DLV+clasp/HCP_encoding.lp {PATH_TO_PROBLEM_INSTANCE} > GROUND_FILENAME.lp`. The command `clasp GROUND_FILENAME.lp` can then be used to obtain a solution.

  

##### newground

After the installation, newground can be started with the command `newground {PATH_TO_PROBLEM_INSTANCE} > NEWGROUND_FILENAME.lp`. The file `NEWGROUND_FILENAME.lp` can then be grounded via gringo or solved via clingo (see above), providing the file as input. Note that the `PATH_TO_PROBLEM_INSTANCE` file must contain the annotated HCP encoding for newground (`newground/HCP_encoding_annotated_newground.lp`) and the facts for the problem instance.

  

##### ProASP

After building ProASP on Linux, the HCP encoding must first be compiled into a hybrid solver using the command `./dist/proasp --compile --source . --propagators ProASP/HCP_encoding_CS-Split_toCompile.asp --grounding ProASP/HCP_encoding_CS-Split_toGround.asp` inside the ProASP folder downloaded from Github. Please note that the .asp-files have to be moved to that directory or the relative path has to be adapted in the command. ProASP can then be used to solve an instance using the command `./dist/proasp --run --source . --instance {PATH_TO_PROBLEM_INSTANCE}`.

  

##### CAG

Execution of the experiments for CAG are explained below in `Execution of incremental solving`.

  

## Execution of incremental solving

  

Similar to the naive application of the tools, clingo, DLV, I-DLV+clasp, newground and ProASP can also be applied in an iterative manner. For execution, a problem instance can be generated as explained above, which can be split into fact batches and fed to the solver in an iterative manner, as explained in our paper. The resulting AS's need to be parsed into input facts and added to the fact batches of the next iteration. This parsing depends on the output format of the solver used and can be done manually.

  

##### Execution of CAG

Experiments for CAG can be run by applying clingo during incremental solving, using the file `HCP_encoding_CAG.lp` from the subdirectory `CAG` as the base encoding.

  

##### PPI (Persons Per Iteration)

The decomposition of the problem instance into fact batches introduces a variable persons-per-iteration (PPI), which describes the number of people whose facts are added to one fact batch for one iteration.

All tools were initially tested with a PPI of 5, as this gave the best performance in both CAG and incremental-ProASP. In addition, incremental-clingo, which is the most effective ground-and-solve system after CAG, was further optimised by determining an optimal PPI of 1.

The optimal PPI was determined by running tests for instances of up to 100 people and summing the execution times of each instance size for a PPI value. The lowest sum indicates that the corresponding PPI value had the lowest execution time and is therefore the optimal PPI. The results of these tests for CAG, incremental-clingo and incremental-ProASP can be found in the `PPI_Tests` subdirectory.
