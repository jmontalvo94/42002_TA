### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ e96ee5ce-ef51-11ea-18f7-5fffcbe97c21
begin
	using Pkg
	Pkg.activate(".")
	Pkg.add.(["LaTeXStrings","Plots", "PlutoUI"])
	using LaTeXStrings
	using Plots
	using PlutoUI
end

# ╔═╡ b31a8560-f132-11ea-2567-ffd1936707d4
html"<button onclick=present()>Present</button>"

# ╔═╡ 7698a280-edcb-11ea-3048-7f291d85476f
md"""
# Module 2 - Introduction to Operations Research 🕵️‍♂️
George B. Dantizg, inventor of the simplex algorithm, on an interview for the College Mathematics Journal[^1]:
>"[...] during my first year at Berkeley I arrived late one day at one of [Jerzy] Neyman’s classes. On the blackboard there were two problems that I assumed had been assigned for homework. I copied them down. A few days later I apologized to Neyman for taking so long to do the homework — the problems seemed to be a little harder than usual. I asked him if he still wanted it. He told me to throw it on his desk. I did so reluctantly because his desk was covered with such a heap of papers that I feared my homework would be lost there forever. About six weeks later, one Sunday morning about eight o’clock, [my wife] Anne and I were awakened by someone banging on our front door. It was Neyman. He rushed in with papers in hand, all excited: “I’ve just written an introduction to one of your papers. Read it so I can send it out right away for publication.” For a minute I had no idea what he was talking about. To make a long story short, the problems on the blackboard that I had solved thinking they were homework were in fact two famous unsolved problems in statistics. That was the first inkling I had that there was anything special about them. A year later, when I began to worry about a thesis topic, Neyman just shrugged and told me to wrap the two problems in a binder and he would accept them as my thesis."
"""

# ╔═╡ e18e0ab0-f133-11ea-0fed-c713308b7a2a
md"
## Exercises 📚
Solve the following exercises from 	`Hillier, Lieberman. Introduction to Operations Research, Eight Edition. pp. 91-95 and 162-163`.

- 3.1 - 4
- 3.1 - 9
- 3.1 - 13
- 3.2 - 6
- 4.1 - 2
- Optional a)
- Optional b)
"

# ╔═╡ e53fab60-ee9e-11ea-0602-456fbb0afe8e
md"
## $3.1-4.$

Use the graphical method to solve the problem:

Maximize:
```math
Z = 2x_1 + x_2
```
subject to:
```math
\begin{aligned}
x_2 &\leq 10 \\
2x_1 + 5x_2 &\leq 60 \\
x_1 + x_2 &\leq 18 \\
3x_1 + x_2 &\leq 44 \\
x_1 \geq 0&,\ x_2 \geq 0 \\
\end{aligned}
```
"

# ╔═╡ 64223ee0-eea2-11ea-278b-ed5d31ebfe83
md"""
!!! hint "Solution 👀"
    ```math
    \begin{aligned}
    x_1 &= 13\\
    x_2 &= 5\\
    Z &= 31
    \end{aligned}
    ```
"""

# ╔═╡ f06c1500-ee9e-11ea-3485-5d8ebf946aae
md"
## $3.1 - 9$.

Weenies and Buns is a food processing plant which manufactures hot dogs and hot dog buns. They grind their own flour for the hot dog buns at a maximum rate of 200 pounds per week. Each hot dog bun requires 0.1 pound of flour. They currently have a contract with Pigland, Inc., which specifies that a delivery of 800 pounds of pork product is delivered every Monday. Each hot dog requires 1/4 pound of pork product. All the other ingredients in the hot dogs and hot dog buns are in plentiful supply. Finally, the labor force at Weenies and Buns consists of 5 employees working full time (40 hours per week each). Each hot dog requires 3 minutes of labor, and each hot dog bun requires 2 minutes of labor. Each hot dog yields a profit of \\$ 0.20, and each bun yields a profit of \\$ 0.10.

Weenies and Buns would like to know how many hot dogs
and how many hot dog buns they should produce each week so as
to achieve the highest possible profit.

**(a)** Formulate a linear programming model for this problem.

**(b)** Use the graphical method to solve this model.
"

# ╔═╡ 68ad3570-ef77-11ea-1ae9-cb0c85fffac0
md"""
!!! hint "Solution 👀"
    a)
    ```math
    \begin{align}
    \text{ Max } Z = 0.2x_1 &+ 0.1x_2\\
    \text{ s.t. } \quad 0.25x_1 &\leq 800\\
    0.1x_2 &\leq 200\\
    3x_1+2x_2 &\leq 12000 \\
    x_1 \geq 0&,\ x_2 \geq 0 \\
    \end{align}
    ```
    b)
    ```math
    \begin{aligned}
    x_1=3200\\
    x_2=1200\\
    Z=760
    \end{aligned}
    ```
"""

# ╔═╡ fe2a6cc0-eea1-11ea-0642-8735d6ad8a43
md"
## $3.1-13.$

Consider the following problem, where the values of $c_1$ and $c_2$ have not yet been ascertained.

Maximize:
```math
Z = c_1x_1 + c_2x_2
```
subject to:
```math
\begin{aligned}
2x_1 + x_2 &\leq 11 \\
-x_1 + 2x_2 &\leq 2 \\
x_1 \geq 0,\ &x_2 \geq 0 \\
\end{aligned}
```

Use graphical analysis to determine the optimal solution(s) for ($x_1 \geq x_2$) for the various possible values of $c_1$ and $c_2$. (Hint: Separate the cases where $c_2 = 0$, $c_2 \geq 0$, and $c_2 \leq 0$. For the latter two cases, focus on the ratio of $c_1$ to $c_2$.)
"

# ╔═╡ 6bea5f10-ef77-11ea-1181-1356c9b3b4e7
md"""
!!! hint "Solution 👀"
    When the constraints are given, the optimal solution depends on the slope of the objective function - given by the ratio $-c_1/c_2$. Explore the different possible values of $-c_1/c_2$. The important slopes are those of the constraint boundaries.
"""

# ╔═╡ 2b4bcf90-eea3-11ea-0a5b-c5507c28ed4e
md"
## $3.2-6.$

Suppose that the following constraints have been provided for a linear programming model.

```math
\begin{aligned}
-x_1 + 3x_2 &\leq 30 \\
-3x_1 + x_2 &\leq 30 \\
x_1 \geq 0&,\ x_2 \geq 0 \\
\end{aligned}
```

**(a)** Demonstrate that the feasible region is unbounded.

**(b)** If the objective is to maximize $Z = -x_1 + x_2$, does the model have an optimal solution? If so, find it. If not, explain why not.

**(c)** Repeat part **(b)** when the objective is to maximize $Z = x_1 - x_2$.

**(d)** For objective functions where this model has no optimal solution, does this mean that there are no good solutions according to the model? Explain. What probably went wrong when formulating the model?
"

# ╔═╡ 6ef52e10-ef77-11ea-0e6c-356bdd085208
md"""
!!! hint "Solution 👀"
    a) The graph is not included but you should see that the feasible region is unbounded when going out of the x-axis.

    b) The optimal solution is:
    ```math
    \begin{aligned}
    x_1 &= 0\\
    x_2 &= 10\\
    Z &= 10\\
    \end{aligned}
    ```
    Look at the sign of $x_1$ and you will see that in order of maximizing the problem, you should ensure that $x_1$ is as small as possible.

    c) There is no optimal solution for this problem. We would have to increase $x_1$ to find a better solution, but we can't find an optimal solution because of unboundedness.

    d) No - we can always find a good solution, but we can also always fond a better solution. There is probably a wrong sign in one of the constraints/objective function or a constraint is missing.
"""

# ╔═╡ f7931ed0-eea5-11ea-038b-75467446c7a9
md"
## $4.1-2.$

Consider the following problem.

Maximize:

$Z = 3x_1 + 2x_2$

subject to:

```math
\begin{aligned}
2x_1 + x_2 &\leq 6 \\
x_1 + 2x_2 &\leq 6 \\
x_1 \geq 0&,\ x_2 \geq 0 \\
\end{aligned}
```

**(a)** Use the graphical method to solve this problem. Circle all the corner points on the graph.

**(b)** For each CPF solution, identify the pair of constraint boundary equations it satisfies.

**(c)** For each CPF solution, identify its adjacent CPF solutions.

**(d)** Calculate $Z$ for each CPF solution. Use this information to identify an optimal solution.

**(e)** Describe graphically what the simplex method does step by step to solve the problem.
"

# ╔═╡ 727b6e9e-ef77-11ea-2b63-21b8b91abd31
md"""
!!! hint "Solution 👀"
    **a)-d)**
    ![solution]($string(pwd(),"/sol412.PNG"))

    **e)** Since the origin belongs to the feasible region, the Simplex method starts from (0; 0). The optimality test for (0; 0) fails, therefore it moves along the x1 axis (highest profit increase), stopping at the first constraint boundary to find CPF solution (3; 0). This solution is not optimal since there is a positive rate of improvement of $Z$ along the boundary of constraint $2x_1 +x_2 \leq 6$. The new solution identified is (2; 2), with $Z = 10$. There are no positive rate of improvement going along any of the boundaries, therefore the Simplex method concludes that (2; 2) is optimal.
"""

# ╔═╡ fe1f7df8-f6e7-11ea-2ee2-6744c121f355
string(pwd(),"/sol412.PNG")

# ╔═╡ 89720990-eea8-11ea-340d-d1985d34a3fd
md"
## Optional exercises🧗‍♀️
"

# ╔═╡ 8f5b6770-eea8-11ea-266b-57c094e40a77
md"
### a)

Minimize:

$Z = 2x_1 + x_2$

subject to:

```math
\begin{aligned}
x_2 &\leq 10 \\
2x_1 + 5x_2 &\geq 60 \\
x_1 + x_2 &= 18 \\
3x_1 &\leq 44 - x_2 \\
x_1 \geq 0,&\ x_2 \geq 0
\end{aligned}
```
"

# ╔═╡ 4e835f40-f133-11ea-2ddf-7310c63a4619
md"""
!!! hint "Solution 👀"
    testing 🤷‍♂️
"""

# ╔═╡ 9a8d9d72-eea8-11ea-3e95-4dc0194f9bdc
md"
### b)

Maximize:

$Z = 2x_1 + x_2$

subject to:

```math
\begin{aligned}
x_2 &\leq 10 \\
2x_1 + 5x_2 &\geq 60 \\
x_1 + x_2 &= 18 \\
3x_1 &\leq 44 - x_2 \\
x_1 \geq 0,&\ x_2 \in \mathbb{R}
\end{aligned}
```
"

# ╔═╡ 5139f3c0-f133-11ea-03c8-193978895b71
md"""
!!! hint "Solution 👀"
    testing 🤷‍♂️
"""

# ╔═╡ 3d39acb0-ef55-11ea-0574-fb3fe10b0565
md"
## Graphical solution
"

# ╔═╡ 24606590-ef54-11ea-22ae-939492342184
md"""
Case:
$(@bind case Select(["3.1 - 4", "3.1 - 9", "3.1 - 13", "3.2 - 6", "4.1 - 2", "Optional a", "Optional b"]))
"""

# ╔═╡ 9234cc82-ef74-11ea-3d32-2bb0fa2e13fb
if case=="3.1 - 4"
	md"""
	Constraint 1: $(@bind c1 CheckBox())
	Constraint 2: $(@bind c2 CheckBox())
	Constraint 3: $(@bind c3 CheckBox())
	Constraint 4: $(@bind c4 CheckBox())
	Objective: $(@bind obj CheckBox())
	"""
elseif case=="3.1 - 9"
	md"""
	Constraint 1: $(@bind c1 CheckBox())
	Constraint 2: $(@bind c2 CheckBox())
	Constraint 3: $(@bind c3 CheckBox())
	Objective: $(@bind obj CheckBox())
	"""
elseif case=="3.1 - 13"
	md"""
	Constraint 1: $(@bind c1 CheckBox())
	Constraint 2: $(@bind c2 CheckBox())
	Objective: $(@bind obj CheckBox())
	"""
elseif case=="3.2 - 6"
	md"""
	Constraint 1: $(@bind c1 CheckBox())
	Constraint 2: $(@bind c2 CheckBox())
	Objective: $(@bind obj CheckBox())
	"""
elseif case=="4.1 - 2"
end

# ╔═╡ d30dca00-f487-11ea-33eb-29cde060f8dd
if case == "3.1 - 13" && obj
	md"""
	c1 = $(@bind coef1 Slider(-3:3, default=1,show_value=true))
	c2 = $(@bind coef2 Slider(-3:3, default=1,show_value=true))
	"""
elseif case == "3.2 - 6" && obj
	md"""
	_**Select only one of the two objective functions!**_
	
	``Z = -x_1 + x_2`` $(@bind obj1 CheckBox())
	``Z = x_1 + x_2`` $(@bind obj2 CheckBox())
	"""
end

# ╔═╡ 373b8730-f12a-11ea-362a-c74556fe7e3f
begin
	plot(widen=false)
	
	if case=="3.1 - 4"
		if c1
		plot!([0, xlims[2]],[10, 10], fillrange=0, fillalpha=0.1,label=L"$x_2 \leq 10$")
		end
		if c2
		plot!([0, 30],[60/5, 0], fillrange=0, fillalpha=0.1,label=L"$2x_1+5x_2 \leq 60$")
		end
		if c3
		plot!([0, 18],[18, 0], fillrange=0, fillalpha=0.1, label=L"$x_1+x_2\leq18$")
		end
		if c4
		plot!([0,44/3],[44,0], fillrange=0, fillalpha=0.1,label=L"$3x_1+x_2\leq44$")
		end
		if obj
		plot!([0,Z/2],[Z,0],label=L"$Z=2x_1+x_2$", color=:red, linestyle=:dash, linewidth=1)
		end
		
	elseif case == "3.1 - 9"
		if c1
		plot!([3200, 3200],[0, ylims[2]], fillrange=0, fillalpha=0.1,label=L"$0.25x_1 \leq 800$")
		plot!([0, 3200],[ylims[2],ylims[2]],fillrange=0, fillalpha=0.1, label=false, color=:lightblue)
		end
		if c2
		plot!([0, xlims[2]],[2000, 2000], fillrange=0, fillalpha=0.1,label=L"$0.1x_2 \leq 200$")
		end
		if c3
		plot!([0, 4000],[6000, 0], fillrange=0, fillalpha=0.1, label=L"$3x_1+2x_2\leq12000$")
		end
		if obj
		plot!([0,Z/0.2],[Z/0.1,0],label=L"$Z=0.2x_1+0.1x_2$", color=:red, linestyle=:dash, linewidth=1)
		end
	
	elseif case == "3.1 - 13"
		if c1
		plot!([0, 11/2],[11, 0], fillrange=0, fillalpha=0.1,label=L"$2x_1+x_2 \leq 11$")
		end
		if c2
		plot!([0, xlims[2]],[1, (2+xlims[2])/2], fillrange=0, fillalpha=0.1, label=L"$-x_1 + 2x_2 \leq 2$")
		end
		if obj
			if coef1==0 && coef2==0
				nothing
			elseif coef1 == 0
				plot!([xlims[1],xlims[2]],[Z/coef2,Z/coef2],label=L"$Z=c_1x_1+c_2x_2$", color=:red, linestyle=:dash, linewidth=1)
			elseif coef2 == 0
				plot!([Z/coef1,Z/coef1],[ylims[1],ylims[2]],label=L"$Z=c_1x_1+c_2x_2$", color=:red, linestyle=:dash, linewidth=1)
			else
				plot!([xlims[1],Z/coef1],[Z/coef2,ylims[2]],label=L"$Z=c_1x_1+c_2x_2$", color=:red, linestyle=:dash, linewidth=1)
			end
		end
		
	elseif case == "3.2 - 6"
		if c1
		plot!([0, 10],[10, 40/3], fillrange=0, fillalpha=0.1,label=L"$-x_1 + 3x_2 \leq 30$")
		end
		if c2
		plot!([0, 10],[30, 60], fillrange=0, fillalpha=0.1, label=L"$-3x_1 + x_2 \leq 30$")
		end
		if obj && obj1
		plot!([0,10],[Z,Z+10],label=L"$Z=-x_1+x_2$", color=:red, linestyle=:dash, linewidth=1)
		end
		if obj && obj2
		plot!([0,Z],[Z,0],label=L"$Z=x_1+x_2$", color=:red, linestyle=:dash, linewidth=1)
		end
		
	end
	
	elseif case == "4.1 - 2"
		if c1
		plot!([0, 10],[10, 40/3], fillrange=0, fillalpha=0.1,label=L"$-x_1 + 3x_2 \leq 30$")
		end
		if c2
		plot!([0, 10],[30, 60], fillrange=0, fillalpha=0.1, label=L"$-3x_1 + x_2 \leq 30$")
		end
		if obj && obj1
		plot!([0,10],[Z,Z+10],label=L"$Z=-x_1+x_2$", color=:red, linestyle=:dash, linewidth=1)
		end
		if obj && obj2
		plot!([0,Z],[Z,0],label=L"$Z=x_1+x_2$", color=:red, linestyle=:dash, linewidth=1)
		end
		
	end
	
	xlims!(xlims)
	ylims!(ylims)
	xlabel!(L"$x_1$")
	ylabel!(L"$x_2$")
end

# ╔═╡ b2dd82b0-f46f-11ea-079b-376595f80407
md"
_Note that the feasible regions for_ $x_1 \geq 0$ _and_ $x_2 \geq 0$ _are not shown/colored._
"

# ╔═╡ b63864f0-ef76-11ea-0ba7-f331f3f5d767
md"
## Notes:
"

# ╔═╡ 3984ecc0-edce-11ea-3419-339fdc003a2d
md"
[^1]: See [The Unsolvable Math Problem](https://www.snopes.com/fact-check/the-unsolvable-math-problem/)
"

# ╔═╡ a360fdf0-edce-11ea-2f42-07bd9073048a
author = (name = "Jorge Montalvo Arvizu", id = "s192184")

# ╔═╡ 3ae326e0-f134-11ea-29c2-fd299efce8da
md"
_42002 - Modelling and analysis of Sustainable Energy Systems using Operations Research_

Prepared by: **_$(author.name)_** ($(author.id)@student.dtu.dk)
"

# ╔═╡ d45491c0-ef6c-11ea-1218-7b672f302a13
begin
	lims = Dict(
		"3.1 - 4" => [(0, 30), (0, 45), (0, 70)],
		"3.1 - 9" => [(0, 4000), (0, 6000), (700, 800)],
		"3.1 - 13" => [(0, 12), (0, 12), (-25, 26)],
		"3.2 - 6" => [(0, 10), (0, 60), (-25, 26)],
		"4.1 - 2" => [(),()],
		"Optional a" => [(),()],
		"Optional b" => [(),()],
	)
	xlims, ylims, zlims = lims[case][1], lims[case][2], lims[case][3]
	nothing
end

# ╔═╡ c4e6572e-ef55-11ea-0754-d9a192eee611
md"""
Z = $(@bind Z Slider(zlims[1]:zlims[2], default=div(zlims[2]-zlims[1],2)+zlims[1],show_value=true))
"""

# ╔═╡ Cell order:
# ╟─3ae326e0-f134-11ea-29c2-fd299efce8da
# ╟─b31a8560-f132-11ea-2567-ffd1936707d4
# ╟─7698a280-edcb-11ea-3048-7f291d85476f
# ╟─e18e0ab0-f133-11ea-0fed-c713308b7a2a
# ╟─e53fab60-ee9e-11ea-0602-456fbb0afe8e
# ╟─64223ee0-eea2-11ea-278b-ed5d31ebfe83
# ╟─f06c1500-ee9e-11ea-3485-5d8ebf946aae
# ╟─68ad3570-ef77-11ea-1ae9-cb0c85fffac0
# ╟─fe2a6cc0-eea1-11ea-0642-8735d6ad8a43
# ╟─6bea5f10-ef77-11ea-1181-1356c9b3b4e7
# ╟─2b4bcf90-eea3-11ea-0a5b-c5507c28ed4e
# ╟─6ef52e10-ef77-11ea-0e6c-356bdd085208
# ╟─f7931ed0-eea5-11ea-038b-75467446c7a9
# ╠═727b6e9e-ef77-11ea-2b63-21b8b91abd31
# ╠═fe1f7df8-f6e7-11ea-2ee2-6744c121f355
# ╟─89720990-eea8-11ea-340d-d1985d34a3fd
# ╟─8f5b6770-eea8-11ea-266b-57c094e40a77
# ╟─4e835f40-f133-11ea-2ddf-7310c63a4619
# ╟─9a8d9d72-eea8-11ea-3e95-4dc0194f9bdc
# ╟─5139f3c0-f133-11ea-03c8-193978895b71
# ╟─3d39acb0-ef55-11ea-0574-fb3fe10b0565
# ╟─24606590-ef54-11ea-22ae-939492342184
# ╟─c4e6572e-ef55-11ea-0754-d9a192eee611
# ╟─9234cc82-ef74-11ea-3d32-2bb0fa2e13fb
# ╟─d30dca00-f487-11ea-33eb-29cde060f8dd
# ╠═373b8730-f12a-11ea-362a-c74556fe7e3f
# ╟─b2dd82b0-f46f-11ea-079b-376595f80407
# ╟─b63864f0-ef76-11ea-0ba7-f331f3f5d767
# ╟─3984ecc0-edce-11ea-3419-339fdc003a2d
# ╟─a360fdf0-edce-11ea-2f42-07bd9073048a
# ╠═e96ee5ce-ef51-11ea-18f7-5fffcbe97c21
# ╠═d45491c0-ef6c-11ea-1218-7b672f302a13
