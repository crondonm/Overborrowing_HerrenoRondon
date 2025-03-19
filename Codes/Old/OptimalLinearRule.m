load('IIPCC.mat')


p = prctile(IIPCC.TAOSim, [0.75, 99]);  
II_TAOSim = IIPCC.TAOSim(IIPCC.TAOSim<=p(2));
temp = find(IIPCC.TAOSim<=p(2));
mB = mean(IIPCC.b(IIPCC.SimB));
mB = IIPCC.b(findClosest2(mB,IIPCC.b));
II_b_gap = IIPCC.b(IIPCC.SimB(temp)) - mB;
X = [ones(size(II_b_gap))', II_b_gap'];
regress(II_TAOSim', X)

