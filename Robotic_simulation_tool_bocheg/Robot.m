classdef Robot < handle
    %% 问题：
    % 1.现在滑膜用不了
    % 2.建模不是CAD模型而是用线和圆来代替的机器人
    %%
    properties
        name; nLinks;
        joint_value; joint_position;
        vec_base;vec_Tool;
        alpha; a; d; theta;delta;
        fmatrix = eye(4);
        q;
    end
    
    methods
        function obj = Robot(name,nLinks,alpha, a, d, theta,delta,vec_Tool)
            obj.name = name;obj.nLinks = nLinks;
            obj.alpha = alpha;obj.a = a;obj.d = d;obj.theta = theta;obj.delta = delta;
            obj.vec_Tool = vec_Tool;
            obj.joint_position = zeros(3, nLinks);
            obj.joint_value = delta + theta;
        end
        
        function forwardkinematics(obj, delta)
            obj.delta = delta;
            [obj.vec_base, obj.fmatrix] = fk(obj.nLinks, obj.alpha, obj.a, obj.d, obj.theta, obj.delta,obj.vec_Tool);
            DH_matrix = eye(4);
            for i = 1:obj.nLinks
                DH_matrix = DH_matrix * DH_transform(deg2rad(obj.alpha(i)), obj.a(i), obj.d(i), deg2rad(obj.theta(i)), obj.joint_value(i));
                pos = DH_matrix * [0; 0; 0; 1];
                obj.joint_position(:, i) = pos(1:3);
            end
        end
        
        function inversekinematics(obj)
            obj.q = ur_ik(obj.alpha,obj.a,obj.d,obj.theta,obj.joint_value,obj.fmatrix);
        end
        
        
        function build(obj)
            figure; hold on; grid on; axis equal;
            xlabel('X'); ylabel('Y'); zlabel('Z');
            title(['Robot: ',obj.name]);
            
            %Draw base
            base_point = [0;0;0];
            plot3(base_point(1),base_point(2),base_point(3),...
                'x','MarkerSize',30);
            for i = 1:obj.nLinks
                if i == 1
                    start_point = base_point;
                else
                    start_point = obj.joint_position(:, i-1);
                end
                end_point = obj.joint_position(:,i);
                % Draw Links
                plot3([start_point(1), end_point(1)],...
                      [start_point(2), end_point(2)],...
                      [start_point(3), end_point(3)],...
                      'b-', 'LineWidth', 2);
                plot3(end_point(1), end_point(2), end_point(3), ...
                      'ko', 'MarkerSize', 8, 'LineWidth', 2);
                text(end_point(1), end_point(2), end_point(3), ...
                     sprintf('q%d: %.2f°', i, (obj.joint_value(i))), ...
                     'FontSize', 10, 'Color', 'red');
            end
            
            flange_coord = obj.vec_base(1:3);
            text(flange_coord(1), flange_coord(2), flange_coord(3), ...
                 sprintf('End: [%.2f, %.2f, %.2f]', flange_coord(1), flange_coord(2), flange_coord(3)), ...
                 'FontSize', 12, 'Color', 'blue', 'FontWeight', 'bold');
            plot3(flange_coord(1), flange_coord(2), flange_coord(3), ...
                  'go', 'MarkerSize', 10, 'LineWidth', 2);            
        
            hold off;
        end
        

   
    end
end
