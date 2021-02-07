clear all
close all
clf
handle_axes= axes('XLim', [-0.6,0.6], 'YLim', [-0.4,0.6], 'ZLim', [0,0.4]);

xlabel('e_1'); 
ylabel('e_2');
zlabel('e_3');

view(-130, 26);
grid on;
axis equal
camlight
axis_length= 0.05;

%% Root frame E
trf_E_axes= hgtransform('Parent', handle_axes); 
% The root-link transform should be created as a child of the axes from the
% beginning to avoid the error "Cannot set property to a deleted object".
% E is synonymous with the axes, so there is no need for plot_axes(trf_E_axes, 'E');

%% Link-0: Base-link

trf_link0_E= make_transform([0, 0, 0], 0, 0, pi/2, trf_E_axes);
plot_axes(trf_link0_E, 'L_0', false, axis_length); 

trf_viz_link0= make_transform([0, 0, 0.1], 0, 0, 0, trf_link0_E);
length0= 0.2; radius0= 0.05;
h(1)= link_cylinder(radius0, length0, trf_viz_link0, [0.823529 0.411765 0.117647]); 
plot_axes(trf_viz_link0, ' ', true, axis_length); % V_0

%% Link-1
trf_viz_link1= make_transform([0, 0, 0], 0, 0, 0); % Do not specify parent yet: It will be done in the joint
length1= 0.05; radius1= 0.04;
h(2)= link_cylinder(radius1, length1, trf_viz_link1, [0, 0, 1]); 
% V_1 and L_1 are the same.

%% Link-1_2
trf_viz_link1p2= make_transform([0.1, 0, 0], 0, 0, 0); % Do not specify parent yet: It will be done in the joint
h(3)= link_box([0.2, 0.02, 0.04], trf_viz_link1p2, [0, 0, 1]); 
plot_axes(trf_viz_link1p2, ' ', true, axis_length); % V_{1-2}

%% Link-1_3
trf_viz_link1p3= make_transform([0.2, 0, 0], 0, 0, 0); % Do not specify parent yet: It will be done in the joint
h(4)= link_cylinder(0.035, 0.05, trf_viz_link1p3, [0, 0, 1]); 
% plot_axes(trf_viz_link1p3, ' ', true, axis_length); % V_{1-3}

%% Link-2
trf_viz_link2= make_transform([0, 0, 0], 0, 0, 0); % Do not specify parent yet: It will be done in the joint
h(5)= link_cylinder(0.03, 0.04, trf_viz_link2, [1, 0.54902, 0]); 
% V_2 and L_2 are the same.

%% Link 2-2
trf_viz_link2p2= make_transform([0, -0.05, 0], pi/2, 0, 0); % Do not specify parent yet: It will be done in the joint
h(6)= link_cylinder(0.015, 0.1, trf_viz_link2p2, [1, 0.54902, 0]); 
% plot_axes(trf_viz_link2p2, ' ', true, axis_length); % V_{2-2}

%% Link-3
trf_viz_link3= make_transform([0, 0, -0.03], 0, 0, 0); % Do not specify parent yet: It will be done in the joint
h(7)= link_cylinder(0.012, 0.06, trf_viz_link3, [0.196078, 0.803922, 0.196078]); 
% plot_axes(trf_viz_link3, ' ', true, axis_length); % V_3

%% Link-3-2
trf_viz_link3p2= make_transform([0, 0, 0], pi/2, 0, 0); % Do not specify parent yet: It will be done in the joint
h(8)= link_cylinder(0.012, 0.04, trf_viz_link3p2, [0.196078, 0.803922, 0.196078]); 
% plot_axes(trf_viz_link3p2, ' ', true, axis_length); % V_{3-2}

%% Link-4
trf_viz_link4= make_transform([0, 0, -0.075], 0, 0, 0); % Do not specify parent yet: It will be done in the joint
h(9)= link_cylinder(0.004, 0.15, trf_viz_link4, [0.482353 0.407843 0.933333]); 
% plot_axes(trf_viz_link4, ' ', true, axis_length); % V_{4}

%% Added Links
%% Link 5
trf_viz_link5= make_transform([0, 0.0075, -0.025], 0, 0, 0); % Do not specify parent yet: It will be done in the joint
h(10)= link_cylinder(0.006, 0.135, trf_viz_link5, [0.482353 0.407843 0.933333]); 
% plot_axes(trf_viz_link5, ' ', true, axis_length); % V_{5}

%% Link 6
trf_viz_link6= make_transform([0, 0, -0.0355], 0, 0, 0); % Do not specify parent yet: It will be done in the joint
h(11)= link_cylinder(0.024, 0.12, trf_viz_link6, [1 0.407843 0]); 
% plot_axes(trf_viz_link6, ' ', true, axis_length); % V_{6}

%% Link-6-7
trf_viz_link6p7= make_transform([0, 0, 0.007], 0, 0, 0); % Do not specify parent yet: It will be done in the joint
h(12)= link_cylinder(0.014, 0.0452, trf_viz_link6p7, [1 0.407843 0]); 
% plot_axes(trf_viz_link6_2, ' ', true, axis_length); % V_{6-7}

%% Link 7
trf_viz_link7= make_transform([0, 0, -0.025], 0, 0, 0); % Do not specify parent yet: It will be done in the joint
h(13)= link_cylinder(0.00875, 0.12, trf_viz_link7, [0.482353 0.407843 0.933333]); 
% plot_axes(trf_viz_link7, ' ', true, axis_length); % V_{7}

%% Link-End-Effector
trf_viz_linkEE= make_transform([0, 0, 0.001], 0, 0, 0); % Do not specify parent yet: It will be done in the joint
h(14)= link_sphere(0.005, trf_viz_linkEE, [1, 0, 0]); 
% plot_axes(trf_viz_linkEE, ' ', true, axis_length); % V_{EE}


%% Now define all the joints

%% Joint 1: Links 0,1: Revolute
j1_rot_axis_j1= [0,0,1]';
j1_rot_angle= 0; % [-pi/2, pi/2]

trf_joint1_link0= make_transform([0, 0, 0.225], 0, 0, 0, trf_link0_E); 
trf_link1_joint1= make_transform_revolute(j1_rot_axis_j1, j1_rot_angle, trf_joint1_link0); 
plot_axes(trf_link1_joint1, 'L_1', false, axis_length); 
make_child(trf_link1_joint1, trf_viz_link1);

%% Joint: Links 1,1_2: Fixed
trf_link1p2_link1= make_transform([0, 0, 0], 0, 0, 0, trf_link1_joint1); 
make_child(trf_link1p2_link1, trf_viz_link1p2);

%% Joint: Links 1,1_3: Fixed
trf_link1p3_link1= make_transform([0, 0, 0], 0, 0, 0, trf_link1_joint1); 
make_child(trf_link1p3_link1, trf_viz_link1p3);

%% Joint 2: Links 1,2: Revolute
j2_rot_axis_j2= [0,0,1]';
j2_rot_angle= 0; % [-pi/2, pi/2]

trf_joint2_link1= make_transform([0.2, 0, 0.045], 0, 0, pi/2, trf_link1_joint1); 
trf_link2_joint2= make_transform_revolute(j2_rot_axis_j2, j2_rot_angle, trf_joint2_link1); 
plot_axes(trf_link2_joint2, 'L_2', false, axis_length); 
make_child(trf_link2_joint2, trf_viz_link2);

%% Joint: Links 2,2_2: Fixed
trf_link2p2_link2= make_transform([0, 0, 0], 0, 0, 0, trf_link2_joint2); 
make_child(trf_link2p2_link2, trf_viz_link2p2);

%% Joint 3: Links 2,3: Revolute
j3_rot_axis_j3= [0,0,1]';
j3_rot_angle= 0; % [-pi/2, pi/2]

trf_joint3_link2= make_transform([0, -0.15, 0], pi/2, 0, 0, trf_link2_joint2);
trf_link3_joint3= make_transform_revolute(j3_rot_axis_j3, j3_rot_angle, trf_joint3_link2); 
plot_axes(trf_link3_joint3, 'L_3', false, axis_length); 
make_child(trf_link3_joint3, trf_viz_link3);

%% Joint: Links 3,3_2: Fixed
trf_link3p2_link3= make_transform([0, 0, 0], 0, 0, 0, trf_link3_joint3); 
make_child(trf_link3p2_link3, trf_viz_link3p2);

trf_link3p2_link3= make_transform([0, 0, 0], 0, 0, 0, trf_link3_joint3); 
make_child(trf_link3p2_link3, trf_viz_link3);

%% Joint 4: Links 3,4: Revolute

j4_rot_axis_j4= [0,0,1]';
j4_rot_angle= 0; % [-pi/2, pi/2]

trf_joint4_link3= make_transform([0, -0.15, 0], pi/2, 0, 0, trf_link3_joint3);
trf_link4_joint4= make_transform_revolute(j4_rot_axis_j4, j4_rot_angle, trf_joint4_link3); 
plot_axes(trf_link4_joint4, 'L_4', false, axis_length); 
make_child(trf_link4_joint4, trf_viz_link4);

%% New Joints
%% Joint 5: Links 4,5: Revolute

j5_rot_axis_j5= [0,0,1]';
j5_rot_angle= 0; % [-pi/2, pi/2]

trf_joint5_link4= make_transform([0, 0.075, 0.01], -pi, 0, 0, trf_link4_joint4);
trf_link5_joint5= make_transform_revolute(j5_rot_axis_j5, j5_rot_angle, trf_joint5_link4); 
plot_axes(trf_link5_joint5, 'L_5', false, axis_length); 
make_child(trf_link5_joint5, trf_viz_link5);

%% Joint 5: Links 5,5_4: Fixed
trf_link5p4_link5= make_transform([0, 0, 0], pi/2, 0, 0, trf_link5_joint5); 
make_child(trf_link5p4_link5, trf_viz_link5);

%% Joint 6: Links 5,6: Revolute

j6_rot_axis_j6= [0,0,1]';
j6_rot_angle= 0; % [-pi/2, pi/2]

trf_joint6_link5= make_transform([0, -0.0125, -0.07], pi, 0, 0, trf_link5_joint5);
trf_link6_joint6= make_transform_revolute(j6_rot_axis_j6, j6_rot_angle, trf_joint6_link5); 
plot_axes(trf_link6_joint6, 'L_6', false, axis_length); 
make_child(trf_link6_joint6, trf_viz_link6);

%% Joint 6: Links 6,6_7: Fixed
trf_joint6_link5= make_transform([0, -0.0125, -0.07], pi, 0, 0, trf_link5_joint5);
trf_link6_joint6= make_transform_revolute(j6_rot_axis_j6, j6_rot_angle, trf_joint6_link5); 
make_child(trf_link6_joint6, trf_viz_link6p7);

%% Joint 7: Links 6,7: Prismatic
j7_translation_axis_j7= [0,0,1]';
j7_translation= 0; % [-0.04, 0.04]

trf_joint7_link6= make_transform([0, -0.07, 0], pi/2, 0, 0, trf_link6_joint6); 
trf_link7_joint7= make_transform_prismatic(j7_translation_axis_j7, j7_translation, trf_joint7_link6);
plot_axes(trf_link7_joint7, 'L_7', false, axis_length); 
make_child(trf_link7_joint7, trf_viz_link7);

%% Joint: Links 7,EE: Fixed
trf_linkEE_link7= make_transform([0, 0, 0], 0, 0, 0, trf_link7_joint7); 
make_child(trf_linkEE_link7, trf_viz_linkEE);

%% Animation: One joint at a time
for q1=[linspace(0, -pi/2, 30), linspace(-pi/2, pi/2, 30), linspace(pi/2, 0, 30)]
    set(handle_axes, 'XLim', [-0.6,0.6], 'YLim', [-0.4,0.6], 'ZLim', [0,0.4]);
    trf_q1= makehgtform('axisrotate', j1_rot_axis_j1, q1);
    set(trf_link1_joint1, 'Matrix', trf_q1);
    drawnow;
    pause(0.02);
end

for q2=[linspace(0, -pi/2, 30), linspace(-pi/2, pi/2, 30), linspace(pi/2, 0, 30)]
    set(handle_axes, 'XLim', [-0.6,0.6], 'YLim', [-0.4,0.6], 'ZLim', [0,0.4]);
    trf_q2= makehgtform('axisrotate', j2_rot_axis_j2, q2);
    set(trf_link2_joint2, 'Matrix', trf_q2);
    drawnow;
    pause(0.02);
end

for q3=[linspace(0, -pi/2, 30), linspace(-pi/2, pi/2, 30), linspace(pi/2, 0, 30)]
    set(handle_axes, 'XLim', [-0.6,0.6], 'YLim', [-0.4,0.6], 'ZLim', [0,0.4]);
    trf_q3= makehgtform('axisrotate', j3_rot_axis_j3, q3);
    set(trf_link3_joint3, 'Matrix', trf_q3);
    drawnow;
    pause(0.02);
end

% New Animation Added here

for q4=[linspace(0, -pi/2, 30), linspace(-pi/2, pi/2, 30), linspace(pi/2, 0, 30)]
    set(handle_axes, 'XLim', [-0.6,0.6], 'YLim', [-0.4,0.6], 'ZLim', [0,0.4]);
    trf_q4= makehgtform('axisrotate', j6_rot_axis_j6, q4);
    set(trf_link6_joint6, 'Matrix', trf_q4);
    drawnow;
    pause(0.02);
end

for a5=[linspace(0, -0.04, 30), linspace(-0.04, 0.04, 30), linspace(0.04, 0, 30)]
    set(handle_axes, 'XLim', [-0.6,0.6], 'YLim', [-0.4,0.6], 'ZLim', [0,0.4]);
    trf_a5= makehgtform('translate', j7_translation_axis_j7*a5);
    set(trf_link7_joint7, 'Matrix', trf_a5);
    drawnow;
    pause(0.02);
end


%% Animation: All joints together.
q_init= 0.5*ones(5,1); % This leads to all joints being at 0.

for i= 1:20
    q_next= rand(5,1); 
    % rand() gives uniformly distributed random numbers in the interval [0,1]
    
    for t=0:0.02:1
        q= q_init + t*(q_next - q_init);
        q1= (pi/2)*(2*q(1) - 1);
        q2= (pi/2)*(2*q(2) - 1);
        q3= (pi/2)*(2*q(3) - 1);
        q4= (pi/2)*(2*q(4) - 1);
        a5= (0.04)*(2*q(4) - 1);
        
        set(handle_axes, 'XLim', [-0.6,0.6], 'YLim', [-0.4,0.6], 'ZLim', [0,0.4]);
        trf_q1= makehgtform('axisrotate', j1_rot_axis_j1, q1);
        set(trf_link1_joint1, 'Matrix', trf_q1);
        
        set(handle_axes, 'XLim', [-0.6,0.6], 'YLim', [-0.4,0.6], 'ZLim', [0,0.4]);
        trf_q2= makehgtform('axisrotate', j2_rot_axis_j2, q2);
        set(trf_link2_joint2, 'Matrix', trf_q2);
        
        set(handle_axes, 'XLim', [-0.6,0.6], 'YLim', [-0.4,0.6], 'ZLim', [0,0.4]);
        trf_q3= makehgtform('axisrotate', j3_rot_axis_j3, q3);
        set(trf_link3_joint3, 'Matrix', trf_q3);
        
        % New animation added here
        set(handle_axes, 'XLim', [-0.6,0.6], 'YLim', [-0.4,0.6], 'ZLim', [0,0.4]);
        trf_q4= makehgtform('axisrotate', j6_rot_axis_j6, q4);
        set(trf_link6_joint6, 'Matrix', trf_q4);
        
        set(handle_axes, 'XLim', [-0.6,0.6], 'YLim', [-0.4,0.6], 'ZLim', [0,0.4]);
        trf_a5= makehgtform('translate', j7_translation_axis_j7*a5);
        set(trf_link7_joint7, 'Matrix', trf_a5);
        drawnow;
        pause(0.005);
        
    end
    
    q_init= q_next;
    
end
