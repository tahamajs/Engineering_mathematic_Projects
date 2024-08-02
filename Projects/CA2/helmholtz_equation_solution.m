function helmholtz_equation_solution
    k = 2 * pi; 

    model = createpde(1);

    R1 = [1,0.8,0.5,0.45]';
    g = decsg(R1,'C1',('C1')');

    geometryFromEdges(model, g);

    figure;
    pdegplot(model,'EdgeLabels','on');
    axis equal;
    title('Geometry with Edge Labels');

    

    specifyCoefficients(model, 'm', 0, 'd', 0, 'c', 1, 'a', -k^2, 'f', 0);

    applyBoundaryCondition(model, 'neumann', 'Edge', 1:model.Geometry.NumEdges, 'g', 0, 'q', -60i);

    generateMesh(model, 'Hmax', 0.05);

    results = solvepde(model);

    u = results.NodalSolution;

    figure;
    pdeplot(model, 'XYData', u, 'Contour', 'on');
    title('Solution to Helmholtz Equation');
    xlabel('x');
    ylabel('y');
end
