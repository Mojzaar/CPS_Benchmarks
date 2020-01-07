## CPS_Benchmarks

These files contain the case study models and codes for "Statistical Verification of Learning-Based Cyber-Physical System." <br/>


These case studies require installed MATLAB R2019a with Simulink and Simulink coder toolboxes. They have tested on windows 10. <br/>

The mountain car case study needs the following toolboxes:<br/>
- Statistics and Machine Learning Toolbox,
- Reinforcement Learning Toolbox.
<br/>
The Bidepdal case study's dependencies are as follows:<br/>

- Statistics and Machine Learning Toolbox,
- Reinforcement Learning Toolbox,
- Simscape,
- Simscape Electrical,
- Simscape Multibody,

For this model, you can find the structure to install the required libraries at https://www.mathworks.com/matlabcentral/fileexchange/64227-matlab-and-simulink-robotics-arena-walking-robot.<br/>

The last case study needs the following toolboxes:<br/>
- Deep learning toolbox,
- Statistics and Machine Learning Toolbox.
    
To re-simulation, in each folder, there exists a **test.m** file, which can be used to run the corresponding simulation.<br/>

Using the test.m file, we can set the algorithm parameters like delta (specification threshold), epsilon (probability threshold), and desired significance level as the inputs for the HPSTL function. <br/>

The outputs of the HPSTL are the resulted assertation, sampling cost, and time consumption to run the algorithm. The outputs of the simulation will appear on the MATLAB workspace. The outputs include the accuracy, sampling cost, SMC execution time, and the algorithm result. Moreover, the algorithm inputs and outputs are available in a structure array (Pr). It worth to mention that the whole simulation time is the summation of the SMC execution time and time to run the Simulink model. Depends on the complexity of the model and specification of the running system, the whole simulation time may vary. You can access the following parameters via Pr variable:<br/>

- **delta**: Specification threshold,
- **epsilon**: Probability threshold,
- **dSigLev**: Desired significance level,
- **algTime**: The average execution time of the SMC algorithm which does not include the whole running time,
- **A**: The obtained assertation by the proposed algorithm,
- **N**: Sampling cost,
- **res**: The SMC result,
- **acc**: The accuracy of the SMC result.

In order to present the results in a more initiative way, after running the test.m file and finishing all the simulations, we can run **printTable.m** function. This function prints the result in the workspace of MATLAB as a table. In the generated table, epsilon and alpha stand for (1-epsilon) and alpha, respectively. <br/>

For MC model and in order to print the Figure 2, After finishing the simulations, you should have 18 numbers of saved data.mat files. Running the **Plotfun** function, we can reproduce the Figure 2 in the paper.<br/>
