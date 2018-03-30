% Conponent data file Made on Feb.25.2005 by Jinming 
% updated with new engine data 06/11/2005

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ICE engine parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1.5L Prius_jpn (Atkinson cycle)engine
% Maximum Power 43kW @4000rpm
% Peak Torque  75 lb-ft @ 4000 rpm.
eng_description='Prius_jpn 1.5L (43kW) from FA model and ANL test data'; 
e_inertia=0.18;           % (kg*m^2), rotational inertia of the engine (unknown)

% SPEED & TORQUE RANGES over which data is defined
% (rad/s), speed range of the engine
eng_map_spd=[104.7 110 115.2 120.4 125.7 130.9 136.1 141.4 ...
            146.6 151.8 157.1 162.3 167.6 172.8 178 183.3 188.5 193.7 199 ...
            204.2 209.4 214.7 219.9 225.1 230.4 235.6 240.9 246.1 251.3 256.6 ...
            261.8 267 272.3 277.5 282.7 288 293.2 298.5 303.7 308.9 314.2 ...
            319.4 324.6 329.9 335.1 340.3 345.6 350.8 356 361.3 366.5 371.8 ...
            377 382.2 387.5 392.7 397.9 403.2 408.4 413.6 418.9];
eng_max_trq=[77.33 78.2 79.07 79.94 80.81 81.68 82.35 82.85 83.35 83.85 ...
            84.35 84.83 85.2 85.58 85.95 86.32 86.7 87.13 87.6 88.08 88.55 ...
            89.02 89.47 89.79 90.11 90.43 90.76 91.08 91.4 91.73 92.05 92.38 ...
            92.7 93.03 93.35 93.67 93.99 94.32 94.64 94.96 95.29 95.61 95.93 ...
            96.26 96.58 96.9 97.22 97.55 97.87 98.19 98.52 98.84 99.17 99.49 ...
            99.81 100.2 100.5 100.9 101.3 101.7 102];
% fuel range is normalized by 1/2.7501
eng_map_fuel=[0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
% torque use map indexed vertically by eng_map_spd and horizontally by eng_map_fuel
% lbft2Nm=1.356; %conversion from lbft to Nm
for i = 1:length(eng_map_spd)
    for j = 1:length(eng_map_fuel)
        eng_map_trq(i,j) = (j-1)/(length(eng_map_fuel)-1)*eng_max_trq(i);
    end
end % This means that at one specific engine speed, independent of what fuel consumption or throttle is used, we are at best BSFC 

% ENGINE FUEL CONSUMPTION
%lookup map for calculate fuel consumption
eng_consum_spd=[104.7 110 115.2 120.4 125.7 130.9 136.1 141.4 ...
            146.6 151.8 157.1 162.3 167.6 172.8 178 183.3 188.5 193.7 199 ...
            204.2 209.4 214.7 219.9 225.1 230.4 235.6 240.9 246.1 251.3 256.6 ...
            261.8 267 272.3 277.5 282.7 288 293.2 298.5 303.7 308.9 314.2 ...
            319.4 324.6 329.9 335.1 340.3 345.6 350.8 356 361.3 366.5 371.8 ...
            377 382.2 387.5 392.7 397.9 403.2 408.4 413.6 418.9];
% lbft2Nm=1.356; %conversion from lbft to Nm
eng_consum_trq=[0 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100];
% (g/s), fuel use map indexed vertically by eng_consum_spd and horizontally by eng_consum_trq
eng_consum_fuel=[0 0.654 0.328 0.238 0.232 0.257 0.29 0.323 0.353 0.381 0.407 0.435 0.465 0.501 0.545 0.599 0.665 0.746 0.842 0.957;
0 0.667 0.342 0.253 0.249 0.275 0.309 0.343 0.375 0.404 0.432 0.46 0.492 0.53 0.575 0.63 0.697 0.779 0.877 0.993;
0 0.679 0.355 0.268 0.265 0.292 0.327 0.363 0.396 0.426 0.455 0.485 0.518 0.557 0.603 0.659 0.728 0.811 0.91 1.03;
0 0.691 0.368 0.282 0.28 0.308 0.345 0.382 0.416 0.447 0.477 0.509 0.543 0.583 0.63 0.688 0.758 0.842 0.942 1.06;
0 0.701 0.38 0.295 0.294 0.324 0.362 0.4 0.435 0.468 0.499 0.531 0.567 0.608 0.657 0.716 0.787 0.872 0.974 1.09;
0 0.711 0.391 0.307 0.308 0.342 0.38 0.418 0.451 0.483 0.515 0.554 0.59 0.632 0.682 0.742 0.815 0.901 1 1.12;
0 0.721 0.402 0.32 0.321 0.359 0.397 0.436 0.474 0.506 0.538 0.58 0.622 0.656 0.707 0.769 0.842 0.93 1.03 1.16;
0 0.731 0.413 0.331 0.334 0.371 0.413 0.453 0.492 0.528 0.559 0.598 0.649 0.68 0.732 0.794 0.869 0.958 1.06 1.19;
0 0.74 0.423 0.343 0.347 0.383 0.425 0.466 0.508 0.548 0.579 0.617 0.668 0.717 0.756 0.82 0.895 0.985 1.09 1.22;
0 0.749 0.433 0.354 0.359 0.395 0.437 0.478 0.52 0.561 0.597 0.636 0.687 0.738 0.78 0.844 0.921 1.01 1.12 1.25;
0 0.758 0.443 0.366 0.372 0.407 0.448 0.49 0.532 0.577 0.611 0.656 0.708 0.76 0.803 0.869 0.947 1.04 1.15 1.27;
0 0.767 0.453 0.377 0.384 0.419 0.46 0.502 0.546 0.594 0.628 0.676 0.728 0.781 0.832 0.893 0.972 1.07 1.18 1.3;
0 0.776 0.464 0.388 0.396 0.43 0.472 0.516 0.563 0.611 0.648 0.697 0.747 0.8 0.852 0.917 0.997 1.09 1.2 1.33;
0 0.785 0.474 0.399 0.409 0.442 0.485 0.533 0.581 0.628 0.669 0.718 0.767 0.819 0.87 0.941 1.02 1.12 1.23 1.36;
0 0.795 0.484 0.411 0.421 0.455 0.503 0.55 0.598 0.645 0.69 0.738 0.787 0.838 0.89 0.97 1.05 1.14 1.26 1.39;
0 0.804 0.495 0.422 0.424 0.472 0.52 0.567 0.615 0.663 0.712 0.763 0.813 0.864 0.918 0.982 1.07 1.17 1.28 1.41;
0 0.814 0.506 0.434 0.446 0.492 0.54 0.588 0.635 0.684 0.738 0.793 0.847 0.901 0.952 1.02 1.1 1.19 1.31 1.44;
0 0.824 0.517 0.446 0.459 0.523 0.56 0.608 0.655 0.705 0.759 0.813 0.868 0.922 0.978 1.05 1.14 1.22 1.34 1.47;
0 0.834 0.528 0.458 0.473 0.568 0.582 0.628 0.676 0.725 0.78 0.834 0.888 0.945 1 1.07 1.16 1.25 1.36 1.5;
0 0.845 0.54 0.471 0.486 0.532 0.624 0.648 0.696 0.746 0.8 0.855 0.911 0.969 1.03 1.09 1.18 1.27 1.39 1.52;
0 0.856 0.552 0.484 0.5 0.546 0.667 0.682 0.716 0.767 0.821 0.878 0.936 0.994 1.05 1.11 1.2 1.3 1.42 1.55;
0 0.868 0.564 0.497 0.514 0.561 0.721 0.725 0.74 0.787 0.845 0.903 0.961 1.02 1.08 1.13 1.22 1.32 1.44 1.58;
0 0.88 0.577 0.511 0.529 0.577 0.633 0.768 0.783 0.81 0.869 0.927 0.985 1.04 1.1 1.16 1.25 1.35 1.47 1.61;
0 0.892 0.59 0.525 0.544 0.592 0.65 0.81 0.826 0.844 0.89 0.949 1.01 1.07 1.13 1.18 1.27 1.38 1.5 1.64;
0 0.905 0.603 0.539 0.559 0.609 0.667 0.873 0.868 0.884 0.924 0.969 1.03 1.09 1.15 1.21 1.29 1.4 1.52 1.66;
0 0.918 0.618 0.554 0.575 0.625 0.684 0.743 0.911 0.927 0.96 1 1.05 1.11 1.17 1.23 1.31 1.43 1.55 1.69;
0 0.932 0.632 0.569 0.591 0.642 0.702 0.762 0.954 0.969 0.993 1.04 1.08 1.13 1.19 1.26 1.35 1.45 1.58 1.72;
0 0.946 0.647 0.585 0.607 0.66 0.72 0.781 1.02 1.01 1.03 1.08 1.12 1.15 1.21 1.3 1.39 1.47 1.61 1.75;
0 0.961 0.663 0.602 0.625 0.678 0.739 0.8 0.859 1.05 1.07 1.11 1.16 1.19 1.24 1.33 1.42 1.5 1.63 1.78;
0 0.976 0.679 0.619 0.642 0.696 0.758 0.82 0.88 1.1 1.11 1.14 1.19 1.23 1.27 1.35 1.44 1.53 1.66 1.81;
0 0.992 0.696 0.636 0.66 0.715 0.778 0.841 0.901 1.18 1.16 1.18 1.23 1.27 1.31 1.37 1.46 1.56 1.69 1.83;
0 1.01 0.713 0.654 0.679 0.734 0.798 0.861 0.923 0.981 1.2 1.21 1.26 1.31 1.35 1.4 1.48 1.59 1.72 1.86;
0 1.03 0.731 0.673 0.698 0.754 0.818 0.883 0.945 1 1.24 1.26 1.29 1.34 1.39 1.43 1.51 1.62 1.75 1.89;
0 1.04 0.749 0.692 0.718 0.775 0.84 0.905 0.967 1.03 1.33 1.3 1.33 1.38 1.42 1.47 1.53 1.65 1.78 1.92;
0 1.06 0.768 0.711 0.738 0.796 0.861 0.927 0.99 1.05 1.11 1.34 1.36 1.41 1.46 1.5 1.56 1.68 1.81 1.95;
0 1.08 0.788 0.732 0.759 0.817 0.883 0.95 1.01 1.07 1.13 1.39 1.4 1.44 1.49 1.54 1.58 1.72 1.84 1.98;
0 1.1 0.808 0.753 0.781 0.839 0.906 0.973 1.04 1.1 1.16 1.48 1.44 1.47 1.52 1.57 1.62 1.75 1.87 2.01;
0 1.12 0.829 0.774 0.803 0.862 0.93 0.997 1.06 1.12 1.19 1.25 1.49 1.51 1.56 1.61 1.65 1.78 1.9 2.05;
0 1.14 0.851 0.796 0.826 0.885 0.953 1.02 1.09 1.15 1.21 1.27 1.54 1.54 1.59 1.64 1.69 1.81 1.93 2.08;
0 1.16 0.873 0.819 0.849 0.909 0.978 1.05 1.11 1.18 1.24 1.3 1.63 1.59 1.62 1.67 1.72 1.84 1.96 2.11;
0 1.19 0.896 0.842 0.873 0.934 1 1.07 1.14 1.2 1.27 1.33 1.73 1.63 1.66 1.7 1.76 1.87 1.99 2.14;
0 1.21 0.919 0.867 0.898 0.959 1.03 1.1 1.17 1.23 1.29 1.36 1.42 1.69 1.69 1.74 1.79 1.91 2.02 2.17;
0 1.23 0.944 0.891 0.923 0.985 1.05 1.13 1.19 1.26 1.32 1.39 1.45 1.79 1.73 1.77 1.82 1.93 2.07 2.21;
0 1.26 0.969 0.917 0.949 1.01 1.08 1.15 1.22 1.29 1.35 1.42 1.48 1.88 1.77 1.81 1.85 1.96 2.1 2.24;
0 1.28 0.994 0.943 0.976 1.04 1.11 1.18 1.25 1.32 1.38 1.45 1.51 1.59 1.84 1.84 1.89 1.99 2.13 2.27;
0 1.31 1.02 0.97 1 1.07 1.14 1.21 1.28 1.34 1.41 1.48 1.55 1.62 1.94 1.87 1.92 2.02 2.17 2.31;
0 1.34 1.05 0.997 1.03 1.09 1.17 1.24 1.31 1.37 1.44 1.51 1.58 1.65 2.03 1.92 1.96 2.05 2.2 2.34;
0 1.36 1.08 1.03 1.06 1.12 1.2 1.27 1.34 1.41 1.47 1.54 1.61 1.68 1.77 2 1.99 2.09 2.23 2.38;
0 1.39 1.1 1.05 1.09 1.15 1.23 1.3 1.37 1.44 1.5 1.57 1.64 1.72 1.8 2.09 2.02 2.13 2.26 2.41;
0 1.42 1.13 1.08 1.12 1.18 1.26 1.33 1.4 1.47 1.54 1.6 1.67 1.75 1.83 2.19 2.06 2.16 2.3 2.45;
0 1.45 1.16 1.11 1.15 1.21 1.29 1.36 1.43 1.5 1.57 1.64 1.71 1.78 1.87 1.96 2.15 2.2 2.34 2.48;
0 1.48 1.19 1.15 1.18 1.25 1.32 1.39 1.47 1.53 1.6 1.67 1.74 1.82 1.9 2 2.24 2.24 2.37 2.52;
0 1.51 1.23 1.18 1.21 1.28 1.35 1.43 1.5 1.57 1.64 1.7 1.78 1.85 1.94 2.03 2.34 2.27 2.41 2.56;
0 1.54 1.26 1.21 1.25 1.31 1.39 1.46 1.53 1.6 1.67 1.74 1.81 1.89 1.97 2.07 2.18 2.31 2.45 2.59;
0 1.58 1.29 1.24 1.28 1.35 1.42 1.5 1.57 1.64 1.71 1.77 1.85 1.92 2.01 2.11 2.21 2.39 2.49 2.63;
0 1.61 1.32 1.28 1.31 1.38 1.45 1.53 1.6 1.67 1.74 1.81 1.88 1.96 2.05 2.14 2.25 2.49 2.52 2.67;
0 1.64 1.36 1.31 1.35 1.42 1.49 1.57 1.64 1.71 1.78 1.85 1.92 2 2.09 2.18 2.29 2.41 2.56 2.71;
0 1.68 1.39 1.35 1.38 1.45 1.53 1.6 1.68 1.75 1.81 1.88 1.96 2.04 2.12 2.22 2.33 2.45 2.6 2.75;
0 1.71 1.43 1.38 1.42 1.49 1.56 1.64 1.71 1.78 1.85 1.92 2 2.07 2.16 2.26 2.37 2.49 2.64 2.79;
0 1.75 1.47 1.42 1.46 1.53 1.6 1.68 1.75 1.82 1.89 1.96 2.03 2.11 2.2 2.3 2.41 2.53 2.67 2.83;
0 1.79 1.5 1.46 1.5 1.56 1.64 1.72 1.79 1.86 1.93 2 2.07 2.15 2.24 2.34 2.45 2.57 2.71 2.87];

    
% % SPEED & TORQUE RANGES over which data is defined
% % (rad/s), speed range of the engine
% eng_map_spd=[1000 1250 1500 1750 2000 2250 2500 2750 3000 3250 3500 4000]*2*pi/60; 
% % fuel range is normalized by 1/2.7501
% eng_map_fuel=[0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
% % torque use map indexed vertically by eng_map_spd and horizontally by eng_map_fuel
% lbft2Nm=1.356; %conversion from lbft to Nm
% eng_map_trq = [
% 0   30.71	57  	57  	57  	57  	57  	57  	57  	57  	57
% 0   21.669	60.5	60.5	60.5	60.5	60.5	60.5	60.5	60.5	60.5
% 0   15.753	48.661	62.5	62.5	62.5	62.5	62.5	62.5	62.5	62.5
% 0   11.584	39.802	64  	64  	64  	64  	64  	64  	64  	64
% 0   8.4334	33.113	57.792	65.9	65.9	65.9	65.9	65.9	65.9	65.9
% 0   5.9121	27.849	49.785	67.2	67.2	67.2	67.2	67.2	67.2	67.2
% 0   3.7954	23.537	43.278	63.019	68.5	68.5	68.5	68.5	68.5	68.5
% 0   1.8362	19.782	37.728	55.674	69.8	69.8	69.8	69.8	69.8	69.8
% 0   0   	16.295	32.755	49.215	65.675	71.1	71.1	71.1	71.1	71.1
% 0   0   	12.924	28.111	43.297	58.483	72.4	72.4	72.4	72.4	72.4
% 0   0   	9.5892	23.69	37.791	51.893	65.994	73.7	73.7	73.7	73.7
% 0   0   	2.7286	15.07	27.412	39.754	52.095	64.437	75.2	75.2	75.2 ]*lbft2Nm;
% 
% % ENGINE FUEL CONSUMPTION
% %lookup map for calculate fuel consumption
% eng_consum_spd=[1000 1250 1500 1750 2000 2250 2500 2750 3000 3250 3500 4000]*2*pi/60; 
% lbft2Nm=1.356; %conversion from lbft to Nm
% eng_consum_trq=[0 6.3 12.5 18.8 25.1 31.3 37.6 43.9 50.1 56.4 62.7 68.9 75.2]*lbft2Nm;
% % (g/s), fuel use map indexed vertically by eng_consum_spd and horizontally by eng_consum_trq
% eng_consum_fuel = [
% 0 0.1513  0.1984  0.2455  0.2925  0.3396  0.3867  0.4338  0.4808  0.5279  0.5279  0.5279  0.5279 
% 0 0.1834  0.2423  0.3011  0.3599  0.4188  0.4776  0.5365  0.5953  0.6541  0.6689  0.6689  0.6689 
% 0 0.2145  0.2851  0.3557  0.4263  0.4969  0.5675  0.6381  0.7087  0.7793  0.8146  0.8146  0.8146 
% 0 0.2451  0.3274  0.4098  0.4922  0.5746  0.6570  0.7393  0.8217  0.9041  0.9659  0.9659  0.9659 
% 0 0.2759  0.3700  0.4642  0.5583  0.6525  0.7466  0.8408  0.9349  1.0291  1.1232  1.1232  1.1232 
% 0 0.3076  0.4135  0.5194  0.6253  0.7312  0.8371  0.9430  1.0490  1.1549  1.2608  1.2873  1.2873 
% 0 0.3407  0.4584  0.5761  0.6937  0.8114  0.9291  1.0468  1.1645  1.2822  1.3998  1.4587  1.4587 
% 0 0.3773  0.5068  0.6362  0.7657  0.8951  1.0246  1.1540  1.2835  1.4129  1.5424  1.6395  1.6395 
% 0 0.4200  0.5612  0.7024  0.8436  0.9849  1.1261  1.2673  1.4085  1.5497  1.6910  1.8322  1.8322 
% 0 0.4701  0.6231  0.7761  0.9290  1.0820  1.2350  1.3880  1.5410  1.6940  1.8470  1.9999  2.0382 
% 0 0.5290  0.6938  0.8585  1.0233  1.1880  1.3528  1.5175  1.6823  1.8470  2.0118  2.1766  2.2589 
% 0 0.6789  0.8672  1.0555  1.2438  1.4321  1.6204  1.8087  1.9970  2.1852  2.3735  2.5618  2.7501 ];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% electric motor parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m_description='PRIUS_JPN 30-kW permanent magnet motor/controller';
m_inertia=0.0226; % (kg*m^2), rotor's rotational inertia																		
m_mass=56.75; % (kg), mass of motor and enclosure

% (rad/s), speed range of the motor
m_map_spd=[0 500 1000 1500 2000 2500 3000 3500 4000 4500  6000]*(2*pi)/60;
% (N*m), torque range of the motor
m_map_trq=[-305 -275 -245 -215 -185 -155 -125 -95 -65 -35 -5 0 5 35	65 95 125 155 185 215 245 275 305];
% (--), efficiency map indexed vertically by m_map_spd and horizontally by m_map_trq
% multiplied by 0.95 because data was for motor only, .95 accounts for inverter/controller efficiencies
m_eff_map=0.95*[...
.905    .905    .905    .905    .905    .905    .905    .905    .905    .905    .905    .905	.905    .905    .905    .905    .905    .905    .905    .905    .905    .905    .905      
0.56	0.59	0.62	0.65	0.68	0.72	0.76	0.80	0.85	0.90	0.87	.905	0.87	0.90	0.85	0.80	0.76	0.72	0.68	0.65	0.62	0.59	0.56
0.72	0.74	0.76	0.78	0.81	0.83	0.86	0.89	0.91	0.94	0.85	.905	0.85	0.94	0.91	0.89	0.86	0.83	0.81	0.78	0.76	0.74	0.72
0.72	0.74	0.76	0.78	0.86	0.88	0.90	0.92	0.93	0.94	0.83	.905	0.83	0.94	0.93	0.92	0.90	0.88	0.86	0.78	0.76	0.74	0.72
0.72	0.74	0.76	0.78	0.86	0.88	0.92	0.93	0.95	0.95	0.82	.905	0.82	0.95	0.95	0.93	0.92	0.88	0.86	0.78	0.76	0.74	0.72
0.72	0.74	0.76	0.78	0.86	0.88	0.92	0.94	0.95	0.95	0.81	.905	0.81	0.95	0.95	0.94	0.92	0.88	0.86	0.78	0.76	0.74	0.72
0.72	0.74	0.76	0.78	0.86	0.88	0.92	0.95	0.96	0.95	0.81	.905	0.81	0.95	0.96	0.95	0.92	0.88	0.86	0.78	0.76	0.74	0.72
0.72	0.74	0.76	0.78	0.86	0.88	0.92	0.95	0.96	0.95	0.80	.905	0.80	0.95	0.96	0.95	0.92	0.88	0.86	0.78	0.76	0.74	0.72
0.72	0.74	0.76	0.78	0.86	0.88	0.92	0.95	0.95	0.95	0.80	.905	0.80	0.95	0.95	0.95	0.92	0.88	0.86	0.78	0.76	0.74	0.72
0.72	0.74	0.76	0.78	0.86	0.88	0.92	0.95	0.95	0.95	0.79	.905	0.79	0.95	0.95	0.95	0.92	0.88	0.86	0.78	0.76	0.74	0.72		
0.72	0.74	0.76	0.78	0.86	0.88	0.92	0.95	0.95	0.95	0.79	.905	0.79	0.95	0.95	0.95	0.92	0.88	0.86	0.78	0.76	0.74	0.72];		

% LIMITS
%m_max_crrnt=90;	% maximum current draw for motor/controller set, A
m_max_crrnt=120;
% UQM's max current is 'adjustable,' above is an estimate
m_min_volts=60;	% minimum voltage for motor/controller set, V
% maximum continuous torque corresponding to speeds in mc_map_spd
m_max_trq_data=[305.0 305.0 305.0 305.0 305.0 244.0 203.3 174.3 152.5 135.6 122.0 110.9 101.7 93.8 87.1 81.3 76.3 71.8 67.8 47.7];
m_spd_data=[0 235 470 705 940 1175 1410 1645 1880 2115 2350 2585 2820 3055 3290 3525 3760 3995 4230 6000]*(2*pi)/60;
m_max_trq=interp1(m_spd_data,m_max_trq_data,m_map_spd,'linear');
m_max_gen_trq=-m_max_trq; % estimate
clear m_max_trq_data m_spd_data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% electric generator parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
g_description='PRIUS_JPN 15-kW permanent magnet motor/controller';
g_inertia=0.0226; % (kg*m^2), rotor's rotational inertia																		
g_mass=32.7; % (kg), mass of machine and enclosure
% (N*m), torque vector corresponding to columns of efficiency & loss maps
g_map_trq=[-55 -45 -35 -25 -15 -5 0 5 15 25 35 45 55];
% (rad/s), speed vector corresponding to rows of efficiency & loss maps
g_map_spd=[-5500 -4000 -3500 -3000 -2500 -2000 -1500 -1000 -500 0 500 1000 1500 2000 2500 3000 3500 4000 5500]*(2*pi)/60; 
% data reported was from 500 rpm to 4000 rpm, values for 0 and 5500 rpm are identical
% to nearest neighbors. Map was mirrored for negative values
% LOSSES AND EFFICIENCIES
% multiply everything by 0.95 for power electronics efficiency
g_eff_map=0.95*[...
0.88	0.89	0.90	0.91	0.90	0.79	0.79	0.79	0.90	0.91	0.90	0.89	0.88
0.88	0.89	0.90	0.91	0.90	0.79	0.79	0.79	0.90	0.91	0.90	0.89	0.88
0.87	0.88	0.90	0.90	0.90	0.80	0.80	0.80	0.90	0.90	0.90	0.88	0.87
0.85	0.87	0.89	0.90	0.90	0.81	0.81	0.81	0.90	0.90	0.89	0.87	0.85
0.83	0.85	0.87	0.89	0.89	0.82	0.82	0.82	0.89	0.89	0.87	0.85	0.83
0.80	0.83	0.85	0.87	0.89	0.82	0.82	0.82	0.89	0.87	0.85	0.83	0.80
0.76	0.79	0.82	0.85	0.87	0.82	0.82	0.82	0.87	0.85	0.82	0.79	0.76
0.68	0.72	0.76	0.80	0.84	0.81	0.80	0.81	0.84	0.80	0.76	0.72	0.68
0.52	0.57	0.63	0.69	0.77	0.80	0.80	0.80	0.77	0.69	0.63	0.57	0.52
0.52	0.57	0.63	0.69	0.77	0.80	0.80	0.80	0.77	0.69	0.63	0.57	0.52
0.52	0.57	0.63	0.69	0.77	0.80	0.80	0.80	0.77	0.69	0.63	0.57	0.52
0.68	0.72	0.76	0.80	0.84	0.81	0.80	0.81	0.84	0.80	0.76	0.72	0.68
0.76	0.79	0.82	0.85	0.87	0.82	0.82	0.82	0.87	0.85	0.82	0.79	0.76
0.80	0.83	0.85	0.87	0.89	0.82	0.82	0.82	0.89	0.87	0.85	0.83	0.80
0.83	0.85	0.87	0.89	0.89	0.82	0.82	0.82	0.89	0.89	0.87	0.85	0.83
0.85	0.87	0.89	0.90	0.90	0.81	0.81	0.81	0.90	0.90	0.89	0.87	0.85
0.87	0.88	0.90	0.90	0.90	0.80	0.80	0.80	0.90	0.90	0.90	0.88	0.87
0.88	0.89	0.90	0.91	0.90	0.79	0.79	0.79	0.90	0.91	0.90	0.89	0.88
0.88	0.89	0.90	0.91	0.90	0.79	0.79	0.79	0.90	0.91	0.90	0.89	0.88];

% LIMITS
g_max_crrnt=300;	% maximum current draw for motor/controller set, A
g_min_volts=60;	% minimum voltage for motor/controller set, V
% maximum continuous torque corresponding to speeds in g_map_spd
% a guess!!
g_max_spd=[-200000 -10000 -8000 -6500 -5500 -4000 -3500 -3000 -2500 -2000 -1500 -1000 -500 0 500 1000 1500 2000 2500 3000 3500 4000 5500 6500 8000 10000 200000]*(2*pi)/60; 
g_max_trq=1.2*[0.01 14.3 18 22 26 36 41 48 55 55 55 55 55 55 55 55 55 55 55 48 41 36 26 22 18 14.3 0.01]; % (N*m)









%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NIMH battery parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ADVISOR data file:  ESS_NIMH6.m     
ess_description='Spiral Wound NiMH Used in Insight & Japanese Prius';
% Assume fix temperature of the model
ess_fixtemp=40;
enable_stop=1;

% SOC RANGE over which data is defined
ess_soc=[0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];  % (--)
% The following data was obtained at 25 deg C.  Assume all values are the same for all temperatures
ess_tmp=[0 25];  % (C) place holder for now

% LOSS AND EFFICIENCY parameters (from ESS_Prius_pack) 
% Parameters vary by SOC horizontally, and temperature vertically
% the average of 5 discharge cycles at 6.5A at 25 deg C was 5.995Ah.
% Data (Ah): 6.030 5.973 5.990 5.989 5.995
ess_max_ah_cap=[6.0 6.0];	% (A*h), max. capacity at 6.5 A, indexed by ess_tmp

% module's resistance to being discharged, indexed by ess_soc and ess_tmp
% The discharge resistance is the average of 4 tests from 10 to 90% soc at the following
%  discharge currents: 6.5, 6.5, 18.5 and 32 Amps
%  The 0 and 100 % soc points were extrapolated
ess_r_dis=[
	0.0377	0.0338	0.0300	0.0280	0.0275	0.0268	0.0269	0.0273	0.0283	0.0298	0.0312
	0.0377	0.0338	0.0300	0.0280	0.0275	0.0268	0.0269	0.0273	0.0283	0.0298	0.0312   ]; 

% module's resistance to being charged, indexed by ess_soc and ess_tmp
% The discharge resistance is the average of 4 tests from 10 to 90% soc at the following
%  discharge currents: 5.2, 5.2, 15 and 26 Amps
%  The 0 and 100 % soc points were extrapolated
ess_r_chg=[
   0.0235	0.0220	0.0205	0.0198	0.0198	0.0196	0.0198	0.0197	0.0203	0.0204	0.0204
	0.0235	0.0220	0.0205	0.0198	0.0198	0.0196	0.0198	0.0197	0.0203	0.0204	0.0204   ]; 
   
% module's open-circuit (a.k.a. no-load) voltage, indexed by ess_soc and ess_tmp
ess_voc=[
	7.2370	7.4047	7.5106	7.5873	7.6459	7.6909	7.7294	7.7666	7.8078	7.9143	8.3645
	7.2370	7.4047	7.5106	7.5873	7.6459	7.6909	7.7294	7.7666	7.8078	7.9143	8.3645
];  

% LIMITS (from ESS_Prius_pack)
ess_min_volts=6;% 1 volt per cell times 6 cells lowest from data was 255V so far 8/26/99
ess_max_volts=9; % 1.5 volts per cell times 6 cells highest from data so far was 361V 8/26/99

% OTHER DATA (from ESS_Prius_pack except where noted)
ess_module_mass=(44*.4536)/20;  % (kg), mass of Insight pack (44 lb Automotive News, July 12) divided by 20 modules								
ess_module_num=40;  %20 modules in INSIGHT pack, 40 modules in Prius Pack

ess_cap_scale=1; % scale factor for module max ah capacity
% user definable mass scaling relationship 
ess_mass_scale_fun=inline('(x(1)*ess_module_num+x(2))*(x(3)*ess_cap_scale+x(4))*(ess_module_mass)','x','ess_module_num','ess_cap_scale','ess_module_mass');
ess_mass_scale_coef=[1 0 1 0]; % coefficients in ess_mass_scale_fun
% user definable resistance scaling relationship
ess_res_scale_fun=inline('(x(1)*ess_module_num+x(2))/(x(3)*ess_cap_scale+x(4))','x','ess_module_num','ess_cap_scale');
ess_res_scale_coef=[1 0 1 0]; % coefficients in ess_res_scale_fun








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% vehicle parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M_total = 1.254*10^3; % Vehicle total mass (kg) % 2765 lb from Toyota Prius Specification
g_gravity = 9.81;
R_tire = 0.287; % Refer to PSAT SAE paper %0.622/2; Tire radius (m) % standard P185/65R15 tire
%num_tire = 4;			% Number of tires per axle
A_frontal = 2.52; % Refer to PSAT SAE paper % 5.2026;	% Vehicle frontal area (m^2)% GUESS
rho_air = 1.2;			% From ADVISOR % Air density % kg/m^3
C_d = 0.3;				% Refer to PSAT SAE paper % Aerodynamic drag coefficient
f_rolling = 0.015; % Rolling resistance %%Jim%%









%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% mechanical gear set parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% planetary gear set parameters
tx_pg_s=30; %number of teeth in sun gear
tx_pg_r=78; %number of teeth in ring gear
gear_no=4; %number of pinion gears

%prius Japanese planetary gear inertia
I_r=0; % ring gear inertia
I_s=0; % sun gear inertia
I_c=0; % carrier gear inertia

I_m = m_inertia; % motor inertia
I_g = g_inertia; % generator inertia
I_e = e_inertia; % engine inertia

% gear ratios
%FR = 4.155; % final drive gear ratio
FR = 3.905; % reference from http://www.spectrum.ieee.org/select/1198/hyb.html

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% dynamic model coefficients
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% new matrix representation of the dynamic model
W2T = [I_s+I_g  0                   0                                   -tx_pg_s*gear_no;
       0        I_c+I_e             0                                   (tx_pg_s+tx_pg_r)*gear_no;
       0        0                   M_total*R_tire^2/FR+I_m*FR+I_r*FR   -FR*tx_pg_r*gear_no;
       tx_pg_s  -(tx_pg_s+tx_pg_r)  tx_pg_r                             0];
T2W = inv(W2T);



% Iv_prime=R_tire^2/FR*M_total+I_m*FR+I_r*FR;
% Ig_prime=I_g+I_s;
% Ie_prime=I_e+I_c;
% 
% R_sun=30; %number of teeth in sun gear
% R_ring=78; %number of teeth in ring gear

% EI_carrier=(R_ring^2*FR*Ie_prime)/((R_ring+R_sun)*Iv_prime)+(R_sun^2*Ie_prime)/((R_ring+R_sun)*Ig_prime)+(R_ring+R_sun);
% ETc_carrier=+((R_ring^2*FR)/((R_ring+R_sun)*Iv_prime)+R_sun^2/((R_ring+R_sun)*Ig_prime));
% ETm_carrier=+(FR*R_ring)/Iv_prime;
% ETs_carrier=-(R_sun)/Ig_prime;
% ETf_carrier=-R_ring/Iv_prime;
% Eroll_carrier=-(R_ring*R_tire)/Iv_prime;
% Eair_carrier=-(R_ring*R_tire^3)/(Iv_prime*FR^2);
% 
% EI_ring=(Iv_prime*(R_ring+R_sun)^2)/(R_ring*Ie_prime*FR)+(R_sun^2*Iv_prime)/(R_ring*Ig_prime*FR)+R_ring;
% ETc_ring=+(R_ring+R_sun)/Ie_prime;
% ETm_ring=+(((R_ring+R_sun)^2/(Ie_prime*R_ring))+(R_sun^2/(Ig_prime*R_ring)));
% ETs_ring=+(R_sun)/Ig_prime;
% ETf_ring=-(((R_ring+R_sun)^2/(Ie_prime*R_ring*FR))+(R_sun^2/(Ig_prime*R_ring*FR)));
% Eroll_ring=-(((R_ring+R_sun)^2/(Ie_prime*R_ring))+(R_sun^2/(Ig_prime*R_ring)))*(R_tire/FR);
% Eair_ring=-(((R_ring+R_sun)^2/(Ie_prime*R_ring))+(R_sun^2/(Ig_prime*R_ring)))*(R_tire^3/FR^3);
% 
% %for Sun Gear Lock Dynamic block
% EI_ring_l=Iv_prime+(FR*Ie_prime*R_ring^2)/(R_ring+R_sun)^2;
% ETc_ring_l=+FR*R_ring/(R_ring+R_sun);
% ETm_ring_l=+FR;
% ETf_ring_l=-1;
% Eroll_ring_l=-R_tire;
% Eair_ring_l=-(R_tire^3/FR^2);