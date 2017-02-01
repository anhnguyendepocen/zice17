% endgame_eq: function to compute endgame mixed strategy equilibrium 
%             John Rust, Georgetown University, January 2017

 function [p1,p2,v1,v2]=endgame_eq(c1,c2);

 global k k1 k2 bet;

 minc=min(c1,c2);

 k=kf(0);

 if (-k+bet*minc/(1-bet) < 0);

   p1=0;
   p2=0;
   if (c1 > c2);
      v1=0;
      v2=(c1-c2)/(1-bet);
   else;
      v2=0;
      v1=(c2-c1)/(1-bet);
   end;

 else;

 if (c1 > c2);

  iv_profit1=-k+bet*c2/(1-bet);
  iv_profit1_gain=iv_profit1;

  iv_profit2=-k+c1-c2+bet*c1/(1-bet);
  ni_profit2=c1-c2+bet*(iv_profit2);

  iv_profit2_gain=iv_profit2-ni_profit2;

 else;

  iv_profit2=-k+bet*c1/(1-bet);
  iv_profit2_gain=iv_profit2;

  iv_profit1=-k+c2-c1+bet*c2/(1-bet);
  ni_profit1=c2-c1+bet*(iv_profit1);

  iv_profit1_gain=iv_profit1-ni_profit1;

 end;

 if (iv_profit1 < 0 & iv_profit2_gain < 0);

    p1=0;
    p2=0;

 elseif (iv_profit1 < 0 & iv_profit2_gain > 0);

    fprintf('Pure strategy MPE where firm 1 does not invest and firm 2 invests\n');
    p1=0;
    p2=1;

 elseif (iv_profit1 > 0 & iv_profit2_gain < 0);

    fprintf('Pure strategy MPE where firm 1 does not invest and firm 2 invests\n');
    p1=0;
    p2=1;

 else;


 if (c1 > c2);

    p2=1-k*(1-bet)/(bet*c2); % for high cost firm, the mixing probability is just a linear equation

    % for low cost firm, need to solve a quadratic equation for p1 and pick the right root

    a=-bet*bet*c1/(1-bet);
    b=bet*c1/(1-bet)-bet*(c1-c2-k);
    c=-k;

    p1u=(-b+sqrt(b^2-4*a*c))/(2*a);
    p1l=(-b-sqrt(b^2-4*a*c))/(2*a);
    p1=1-p1u;
    v2=(c1-c2)/(1-bet*p1u);
    v2invest=c1-c2-k+bet*p1u*c1/(1-bet);
     
    if (1-p1l > 0 & 1-p1l < 1)
      fprintf('2nd mixed strategy solution for firm 1: %g\n',1-p1l);
    end;

    v1=0;

  else;

    p1=1-k*(1-bet)/(bet*c1);  % for high cost firm, the mixing probability is just a linear equation

    % for low cost firm, need to solve quadratic equation for p2 and pick the right root

    a=-bet*bet*c2/(1-bet);
    b=bet*c2/(1-bet)-bet*(c2-c1-k);
    c=-k;

    p2u=(-b+sqrt(b^2-4*a*c))/(2*a);
    p2l=(-b-sqrt(b^2-4*a*c))/(2*a);
    p2=1-p2u;
    v1=(c2-c1)/(1-bet*p2u);
    v1invest=c2-c1-k+bet*p2u*c2/(1-bet);
     
    if (1-p2l > 0 & 1-p2l < 1)
      fprintf('2nd mixed strategy solution for firm 2: %g\n',1-p2l);
    end;

    v2=0;

  end;

  end;

  end;
