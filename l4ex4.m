function l4ex4
  clc
  x0 = [2.5; 2.5]; 
  maxiteracoes = 1000;
  tolerancia = 1e-3;
  historicox1 = zeros(2, maxiteracoes);
  
  flagmetodo = menu('Qual o método desejado?','Gradiente','Newton');
  % 1- Gradiente 2- Newton
  [iteracoes, x1, historicox1] = metodo(flagmetodo, x0, maxiteracoes, tolerancia, historicox1);
  figure(1); graficorosa(historicox1(1, :), historicox1(2, :), iteracoes, flagmetodo);
  figure(2); convergenciarosa(historicox1(1, :), historicox1(2, :), iteracoes, flagmetodo);
  
  if flagmetodo == 1
    % Retorno Gradiente
    fprintf("O resultado do Método do Gradiente foi x1 = %.6f x2 = %.6f} e a a proximidade do ponto ótimo é [3; 2] foi de %.6f utilizando %.0f interacoes", x1(1), x1(2), sqrt((x1(1)-3).^2+(x1(2)-2).^2), iteracoes);
  elseif flagmetodo == 2
    % Retorno Newton
    fprintf("O resultado do Método de Newton foi {x1,x2} = {%.6f; %.6f} e a proximidade do ponto ótimo {3; 2} foi de %.6f com %.0f interacoes", x1(1), x1(2), sqrt((x1(1)-3).^2+(x1(2)-2).^2), iteracoes);
  endif
endfunction

function fponto = funcao(ponto)
  x1 = ponto(1);
  x2 = ponto(end);
  fponto = (((x1^2) +  x2 - 11).^2) + (x1 + (x2.^2) - 7).^2;
endfunction

function gponto = gradiente(ponto)
  x1 = ponto(1);
  x2 = ponto(end);
  gponto = [4.*x1.*(x1.^2 + x2 - 11) + 2.*(x1 + x2.^2 - 7);
          2.*(x1.^2 + x2 - 11) + 4.*x2.*(x1 + x2.^2 - 7)];
endfunction

function hponto = hessiana(ponto)
  x1 = ponto(1);
  x2 = ponto(end);
  hponto = [(12.*x1.^2 + 4.*x2 - 42), (4.*x1 + 4.*x2);
          (4.*x1 + 4.*x2), (4.*x1 + 12.*x2.^2 - 12)];
endfunction

function [i, x1, historicox1] = metodo(flagmetodo, x0, maxiteracoes, tolerancia, historicox1)
  for i = 1:maxiteracoes
    if flagmetodo == 1
      % Fazendo Gradiente
      x1 = x0 - 0.02.* gradiente(x0);
    elseif flagmetodo == 2
      % Fazendo Newton
      hponto = hessiana(x0);
      gponto = gradiente(x0);
      x1 = x0 - 1.1.* inv(hponto) * gponto;
    endif
    historicox1(:, i) = x1;
    if max(abs(x1 - x0)) <= tolerancia
      historicox1 = historicox1(:, 1:i);
      break;
    endif
    x0 = x1;
  endfor
endfunction

function graficorosa(historicox1, historicofx1, iteracoes, flagmetodo)
  custom_colormap = [
    1.0 0.5 0.8; 
    0.95 0.45 0.775;  
    0.9 0.4 0.75; 
    0.85 0.35 0.725; 
    0.8 0.3 0.7; 
    0.75 0.25 0.675;  
    0.7 0.2 0.65; 
    0.65 0.15 0.625;
    0.6 0.1 0.6];
  colormap(custom_colormap);
  x = (-6):00.1:6;
  y = x;
  historicoz = zeros(iteracoes);
  for k = 1:iteracoes
    historicoz(k) = funcao([historicox1, historicofx1]);
  endfor
  F = zeros(length(x), length(y));
  for xx = 1:numel(x)
    for yy = 1:numel(y)
      F(xx, yy) = funcao([x(xx); y(yy)]);
    endfor
  endfor
  for i = 1:iteracoes
    surf(x, y, F(:, :));
    shading interp;
    colormap();
    hold on;
    plot3((historicox1(i)), (historicofx1(i)), (historicoz(i)), 'marker', 'o', 'markersize', 20, 'color', 'w', 'markerfacecolor', [0.9922, 0.0000, 0.5490], 'linewidth', 1);
    hold off;
    set(gca, 'fontsize', 10);
    %grid on;
    if flagmetodo == 1
      % Fazendo Gradiente
      title(sprintf('Gradiente %i° iteração', i));
    elseif flagmetodo == 2
      % Fazendo Newton
      title(sprintf('Newton %i° iteração', i));
    endif
    legend("F(x1,x2)=(x1.^2+x2-11).^2+(x1+x2.^2-7).^2", "Ponto");
    xlabel("x1");
    ylabel("x2");
    zlabel("F(x1,x2)");
    pause (0.1);
  endfor
endfunction

function convergenciarosa(historicox1, historicofx1, iteracoes, flagmetodo)
  subplot(211)
  plot(1:iteracoes, historicox1, 'color', [0.9922, 0.0000, 0.5490], 'linewidth', 4);
  set(gca, 'fontsize', 10);
  legend("x1(1)");
  xlabel("Iteracoes");
  if flagmetodo == 1
    % Fazendo Gradiente
    ylabel("x1 = x0 - 0.02.* gradiente(x0)");
  elseif flagmetodo == 2
    % Fazendo Newton
    ylabel("x1 = x0 - 1.1.* inv(hponto) * gponto;");
  endif
  title("Graficos de Convergencia");
  subplot(212)
  plot(1:iteracoes, historicofx1, 'color', [0.9922, 0.0000, 0.5490], 'linewidth', 4)
  set(gca, 'fontsize', 10);
  legend("x1(2)");
  xlabel("Iterações");
endfunction