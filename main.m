clc
clear all
close all

% --------------input parameters
visualizeMesh = 0;

x_start = -50;
x_spacing = 2;
x_end = 50;

y_start = -60;
y_spacing = 2;
y_end = 60;

z_start = -70;
z_spacing = 2;
z_end = 70;

% ------------------------------ run --------

x = x_start:x_spacing:x_end;
y = y_start:y_spacing:y_end;
z = z_start:z_spacing:z_end;

[X, Y, Z] = meshgrid(x, y, z);

SizeX = size(X, 1);
SizeY = size(X, 2);
SizeZ = size(X, 3);

Pnts = [X(:), Y(:), Z(:)];
NumPnt = size(Pnts, 1);

StructOfCubes = X;
StructOfCubes(:, :, :) = reshape([1:SizeX * SizeY * SizeZ], [SizeX, SizeY, SizeZ]);

clear x y z X Y Z

NumCubesX = SizeX - 1;
NumCubesY = SizeY - 1;
NumCubesZ = SizeZ - 1;

NumCubes = NumCubesX * NumCubesY * NumCubesZ;
Cubes = zeros(NumCubes, 8);
Cubes(:, 1) = reshape(StructOfCubes(1:SizeX - 1, 1:SizeY - 1, 1:SizeZ - 1), [NumCubes, 1]);
Cubes(:, 2) = reshape(StructOfCubes(2:SizeX, 1:SizeY - 1, 1:SizeZ - 1), [NumCubes, 1]);
Cubes(:, 3) = reshape(StructOfCubes(2:SizeX, 2:SizeY, 1:SizeZ - 1), [NumCubes, 1]);
Cubes(:, 4) = reshape(StructOfCubes(1:SizeX - 1, 2:SizeY, 1:SizeZ - 1), [NumCubes, 1]);

Cubes(:, 5) = reshape(StructOfCubes(1:SizeX - 1, 1:SizeY - 1, 2:SizeZ), [NumCubes, 1]);
Cubes(:, 6) = reshape(StructOfCubes(2:SizeX, 1:SizeY - 1, 2:SizeZ), [NumCubes, 1]);
Cubes(:, 7) = reshape(StructOfCubes(2:SizeX, 2:SizeY, 2:SizeZ), [NumCubes, 1]);
Cubes(:, 8) = reshape(StructOfCubes(1:SizeX - 1, 2:SizeY, 2:SizeZ), [NumCubes, 1]);

clear StructOfCubes

%--------------------

% Cubes, Pnt
% define bones and pores

%-------------------

if (visualizeMesh > 0)
    figure(1)
    view(3); hold on
    patch('Vertices', Pnts, 'Faces', Cubes(:, [1:4, 1]), 'FaceVertexCData', Cubes(:, 1), 'FaceColor', 'flat', 'EdgeAlpha', 1, 'facealpha', 0);
    hold on
    patch('Vertices', Pnts, 'Faces', Cubes(:, [5:8, 5]), 'FaceVertexCData', Cubes(:, 1), 'FaceColor', 'flat', 'EdgeAlpha', 1, 'facealpha', 0);
    hold on
    patch('Vertices', Pnts, 'Faces', Cubes(:, [1, 2, 6, 5, 1]), 'FaceVertexCData', Cubes(:, 1), 'FaceColor', 'flat', 'EdgeAlpha', 1, 'facealpha', 0);
    hold on
    patch('Vertices', Pnts, 'Faces', Cubes(:, [4, 3, 7, 8, 4]), 'FaceVertexCData', Cubes(:, 1), 'FaceColor', 'flat', 'EdgeAlpha', 1, 'facealpha', 0);
    hold on
    patch('Vertices', Pnts, 'Faces', Cubes(:, [2, 3, 7, 6, 2]), 'FaceVertexCData', Cubes(:, 1), 'FaceColor', 'flat', 'EdgeAlpha', 1, 'facealpha', 0);
    hold on
    patch('Vertices', Pnts, 'Faces', Cubes(:, [4, 1, 5, 8, 4]), 'FaceVertexCData', Cubes(:, 1), 'FaceColor', 'flat', 'EdgeAlpha', 1, 'facealpha', 0);
    hold on

    xlim([x_start - 1, x_end + 1])
    ylim([y_start - 1, y_end + 1])
    zlim([z_start - 1, z_end + 1])

    xlabel('x')
    ylabel('y')
    zlabel('z')
end
