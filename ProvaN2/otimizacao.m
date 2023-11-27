function otimizacao()
  clc;
  x0 = [2.5 ; 2.5];
  xestimado = [3 ; 2];
  maxIteracoes = 1000;
  tolerancia = 1e-3;
  historicox1 = zeros(2, maxIteracoes);
  flag = menu('Qual método', 'gradiente', 'newton');
  [x1, historicox1, iteracoes] = metodo(flag, x0, maxIteracoes, tolerancia, xestimado, historicox1) 
  plotarconvergencia(historicox1, iteracoes);
endfunction

function plotarconvergencia(historicox1, iteracoes)
  subplot(211)
  plot(1:iteracoes, historicox1(1, :))
  subplot(212)
  plot(1:iteracoes, historicox1(2, :))
endfunction

function [x1, historicox1, i] = metodo(flag, x0, maxIteracoes, tolerancia, xestimado, historicox1) 
  for i = 1:maxIteracoes
    if flag == 1
      x1 = x0 - 0.02.* gradiente(x0);
    elseif flag == 2
      x1 = x0 - 1.1.* inv(hessiana(x0))*gradiente(x0);
    endif
   historicox1(:, i) = x1;
   if max(abs(x0 - x1)) <= tolerancia
     historicox1 = historicox1(:, 1:i);
     break
   endif
  x0 = x1;
  endfor
endfunction

function gponto = gradiente(x0)
  x = x0(1);
  y = x0(end);
  gponto = [4.*x.*(x.^2 + y - 11) + 2.*(x + y.^2 - 7);
          2.*(x.^2 + y - 11) + 4.*y.*(x + y.^2 - 7)];
endfunction

function hponto = hessiana(x0)
  x = x0(1);
  y = x0(end);
  hponto = [(12.*x.^2 + 4.*y - 42), (4.*x + 4.*y);
          (4.*x + 4.*y), (4.*x + 12.*y.^2 - 12)];
endfunction

function y = funcao(x0)
  x = x0(1);
  y = x0(end);
  y = (x.^2 + y - 11).^2 + (x + y.^2 - 7).^2;
endfunction
