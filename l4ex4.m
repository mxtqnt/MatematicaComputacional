function l4ex4
  clc
  x0 = [2.5; 2.5]; 
  maxiteracoes = 1000;
  tolerancia = 1e-3;
  historicox1 = zeros(2, maxiteracoes);
  
  flagmetodo = menu('Qual o método desejado?','Gradiente','Newton');
  % 1- Gradiente 2- Newton
  [i, x1, historicox1] = metodo(flagmetodo, x0, maxiteracoes, tolerancia, historicox1);
  
  if flagmetodo == 1
    % Retorno Gradiente
    fprintf("O resultado do método do gradiente foi x1 = %.6f x2 = %.6f}", x1(1), x1(2));
    fprintf("\n a proximidade do ponto ótimo é [3; 2] foi de %.6f utilizando %.0f interacoes", sqrt((x1(1)-3).^2+(x1(2)-2).^2), i);
  elseif flagmetodo == 2
    % Retorno Newton
    fprintf("O resultado do método da hessiana foi {x1,x2} = {%.6f; %.6f}", x1(1), x1(2));
    fprintf("\nSua proximidade do ponto ótimo {3; 2} foi de %.6f com %.0f interacoes", sqrt((x1(1)-3).^2+(x1(2)-2).^2), i);
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
