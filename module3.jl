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

# ╔═╡ e53fab60-ee9e-11ea-0602-456fbb0afe8e
md"
## $3.4-4.$

Use the graphical method to solve the problem:

Minimize:
```math
Z = 3x_1 + 2x_2
```
subject to:
```math
\begin{aligned}
x_1 + 2x_2 &\leq 12 \\
2x_1 + 3x_2 &= 12 \\
2x_1 + x_2 &\geq 8 \\
x_1 \geq 0,\ x_2 &\geq 0 \\
\end{aligned}
```
"

# ╔═╡ 64223ee0-eea2-11ea-278b-ed5d31ebfe83
md"""
!!! hint "Solution 👀"
    ```math
    \begin{aligned}
    x_1 &= 3\\
    x_2 &= 2\\
    Z &= 13
    \end{aligned}
    ```
"""

# ╔═╡ 24606590-ef54-11ea-22ae-939492342184
md"""
### Graphical solution
---

``Z=3x_1+2x_2``: $(@bind obj CheckBox())

``x_1 + 2x_2 \leq 12``: $(@bind c1 CheckBox())

``2x_1 + 3x_2 = 12``: $(@bind c2 CheckBox())

``2x_1 + x_2 \geq 8``: $(@bind c3 CheckBox())

``Z`` = $(@bind Z Slider(0:18, default=0,show_value=true))
"""

# ╔═╡ 1be9eb68-f905-11ea-0097-372fc9887503
begin
	lims = [(0, 12), (0, 10), (0, 13)]
	xlims, ylims, zlims = lims[1], lims[2], lims[3]
	
	plot(widen=false)
	
	if c1
		plot!([0, 12], [6, 0], fillrange=0, fillalpha=0.1,label=L"$x_1 + 2x_2 \leq 12$")
	end
	if c2
		plot!([0, 6],[4, 0], label=L"$2x_1 + 3x_2 = 12$", linewidth=2)
	end
	if c3
		plot!([0, 12],[8, -16], fillrange=10, fillalpha=0.1, label=L"$2x_1 + x_2 \geq 8$")
	end
	if obj
		plot!([0,Z/3],[Z/2,0], label=L"$Z=3x_1+2x_2$", color=:red, linestyle=:dash, linewidth=1)
	end
	
	if obj && Z == 13
		scatter!([3], [2], color="red", label="Optimal solution")
		annotate!((3.3, 2.5, text("Optimal solution", :left)))
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

# ╔═╡ f06c1500-ee9e-11ea-3485-5d8ebf946aae
md"
## Exercise 1

Consider the economic dispatch problem for a very small power system with only two units, Unit 1 and Unit 2.

**a)** Solve the economic dispatch problem for one time period. Unit 1 is a coal-fired steam unit with minimum and maximum generation levels of 150 MW and 350 MW and production costs of 600 Euro/MW. Unit 2 is a oil-fired steam unit with minimum and maximum generation levels of 50 MW and 500 MW and production costs of 900 Euro/MW. Demand is 600 MW.

**b)** Is the problem feasible for any data set? Is it bounded for any data set? (Hint: Look at minimum and maximum generation levels).

**c)** Extend the economic dispatch problem to include two time periods. Demand in the first and second time periods is 600 MW and 400 MW, respectively. Solve this problem.

**d)** Adapt the model such that the production cost includes a variable cost of operation and maintenance ``a_i^{O\&M}`` (Euro/MWh) of Unit ``i``, a fuel cost ``a_i^{fuel}`` (Euro/MWh) of Unit ``i`` and an emission costs ``a_i^{emis}`` (Euro/T) for Unit ``i`` for ``i`` = 1; 2. Denote the amount of emissions from burning fuel by ``p^{emis}`` (T/MWh). Extend this formulation to include a fuel efficiency ``\eta_i^{fuel}`` (note that the fuel efficiency has an impact on both fuel and emission costs).

**e)** Introduce a constraint that forces the generation level of Unit 1 to
be constant, e.g., equal to the parameter ``p_1^{const}`` or 300 MW.
"

# ╔═╡ 68ad3570-ef77-11ea-1ae9-cb0c85fffac0
md"""
!!! hint "Solution 👀"
    **a)**
    ```math
    \begin{align}
    \text{ Min } Z = 600p_1 + 900p_2\\
    \text{ s.t. } \quad 150 \leq p_1 \leq 350\\
    50 \leq p_2 \leq 500\\
    p_1 + p_2 = 600 \\
    p_1 \geq 0,\ p_2 \geq 0 \\
    \end{align}
    ```
    And the solution is:
    ```math
    \begin{aligned}
    p_1^* &= 350\ \text{[MWh]}\\
    p_2^* &= 600 - 350 = 250\ \text{[MWh]}\\
    z^* &= 600\cdot350 + 900\cdot250 = 435,000\ \text{[Euro]}
    \end{aligned}
    ```

    **b)** The problem is feasible for:
    ```math
    \begin{aligned}
    50+150 \leq d \leq 500 + 350 \quad \Leftrightarrow \quad 200 \leq d \leq 850
    \end{aligned}
    ```
    Since ``p_1`` and ``p_2`` are bounded, the problem will always be bounded.
    
    **c)** The problem will not be time dependent, thus, you can solve the problem one period at the time. Solution to the for time period is found in **a)**, the solution to the second time period is:
    ```math
    \begin{aligned}
    p_1^* &= 350\ \text{[MWh]}\\
    p_2^* &= 50\ \text{[MWh]}\\
    z^* &= 255,000\ \text{[Euro]}
    \end{aligned}
    ```
    Hence, the overall solution can be written as:

    $$p_1^* = (350, 350),\ p_2^* = (250, 50),\ z^* = 690,000$$

    **d)** Production costs:

    $$a_i = a_i^{O\&M}+\frac{a_i^{fuel}+a_i^{emis}\cdot p_i^{emis}}{\eta_i^{fuel}},\ 0 \leq \eta_i^{fuel} \leq 1$$

    **e)**

    $$p_1^{const} = 300\ \text{MW};\ p_1^{min} = 300 \leq p_1 \leq 300 = p_1^{max}$$
"""

# ╔═╡ bb61b24a-f911-11ea-27b7-997c31ecf3d1
md"""
### Graphical solution
---

``p_1^{min}``: $(@bind p1_min TextField(default="150"))

``p_1^{max}``: $(@bind p1_max TextField(default="350"))

``p_2^{min}``: $(@bind p2_min TextField(default="50"))

``p_2^{max}``: $(@bind p2_max TextField(default="500"))

``d`` = $(@bind d Slider(0:50:850, default=600,show_value=true))
"""

# ╔═╡ ccd2b7ba-f912-11ea-0b59-15c824b2afdc
begin
	# Assess that we can parse the minimum and maximum
	for option in [p1_min, p1_max, p2_min, p2_max]
		try
			parse(Int, option)
		catch
			throw("You should have entered a numeric value!")
		end
	end
	
	p1min = parse(Int, p1_min)
	p1max = parse(Int, p1_max)
	p2min = parse(Int, p2_min)
	p2max = parse(Int, p2_max)
	
	lims2 = [(0, 1000), (0, 1000)]
	xlims2, ylims2 = lims2[1], lims2[2]
	
	plot(widen=false, legend=:topleft)
	
	plot!([0,p1min+p2min], [0,0], label=L"p_1^{min}+p_2^{min}")
	
	plot!([p1min+p2min, p1max+p2min], [0, 600], linetype=:steppre, label=L"p_1^{max}-p_1^{min}")
	
	plot!([p1max+p2min, p2max+p1max], [600, 900], linetype=:steppre, label=L"p_2^{max}-p_2^{min}")
	
	plot!([d,d], [0,ylims2[2]], label="Demand", color="red")
	
	xlims!(xlims2)
	ylims!(ylims2)
	xlabel!("Production [MWh]")
	ylabel!("Cost [Euro]")
	
end

# ╔═╡ fe2a6cc0-eea1-11ea-0642-8735d6ad8a43
md"
## Exercise 2

In contrast to taking a systems perspective, consider the economic dispatch problem from the perspective of a producer. When selling production in an electricity market, most producers rely on profit maximization rather than cost minimization and are not obliged to meet demand. Reformulate the economic dispatch problem as a profit maximization problem by introducing market prices and ignoring the demand constraints. What does this mean for the structure of the problem in terms of solving it? (Hint: Smaller problems are usually easier to solve).
"

# ╔═╡ 6bea5f10-ef77-11ea-1181-1356c9b3b4e7
md"""
!!! hint "Solution 👀"
    Producer's economic dispatch:

    ```math
    \begin{aligned}
    \text{max}\ \sum_{i=1}^I \sum_{t=1}^T \left( p_i-a_i\right)p_{it}&\qquad\\
    \text{s.t.}\ p_i^{min} \leq p_{it} \leq p_i^{max}&\qquad \forall i \in I,\ \forall t \in T\\
    p_{it} \geq 0&\qquad \forall i \in I,\ \forall t \in T\\
    \end{aligned}
    ```
    where ``p_i`` is the revenue.

    No demand satisfaction ``\rightarrow`` no unit and time coupling constraints ``\Rightarrow`` the problem can now be solved for each unit (one unit at-a-time) and each time period individually.
"""

# ╔═╡ 2b4bcf90-eea3-11ea-0a5b-c5507c28ed4e
md"
## Exercise 5

Consider the economic dispatch model for electricity system operation. Assume that all units are dispatched in two markets; a dayahead market and an intra-day market. You can think of the day-ahead and intra-day markets as two different markets and ignore the time aspect indicated by their names (the physical dispatch of production takes place within the same time horizon for the two markets). At the day-ahead market, **`forecasted`** demand ``d_t^{forecast}`` must be satisfied by production in every time period of the scheduling horizon. However, since the demand forecast is not entirely correct, at the intra-day market, **`realized`** demand ``d_t^{realized}`` must be satisfied by adjusting production in every time period. Production can be adjusted both upwards and downwards in the intraday market. Reformulate the economic dispatch model to include the two markets (Hint: You will need two demand constraints and two sets of variables that takes care of production and adjustments to production, respectively).
"

# ╔═╡ 6ef52e10-ef77-11ea-0e6c-356bdd085208
md"""
!!! hint "Solution 👀"
    ```math
    \begin{aligned}
    \min & \sum_{i=1}^{I} \sum_{t=1}^{T} a_{i}\left(p_{i t}+p_{i t}^{+}-p_{i t}^{-}\right) &\qquad\\
    \text {st } & p_{i}^{\min } \leq p_{i t}+p_{i t}^{+}-p_{i t}^{-} \leq p_{i}^{\max } &\qquad \forall i \in I,\ \forall t \in T\\
    & \sum_{i=1}^{I} p_{i t}=d_{t}^{f o r e c a s t} &\qquad \forall t \in T\\
    & \sum_{i=1}^{I}\left(p_{i t}+p_{i t}^{+}-p_{i t}^{-}\right)=d_{t}^{r e a l i z e d} &\qquad \forall t \in T\\
    & p_{i t}, p_{i t}^{+}, p_{i t}^{-} \geq 0&\qquad \forall i \in I,\ \forall t \in T
    \end{aligned}
    ```
    
    where ``p_{it}^+`` is up-regulation and ``p_{it}^-`` is down-regulation.
"""

# ╔═╡ f7931ed0-eea5-11ea-038b-75467446c7a9
md"
## Exercise 6

Formulate the economic dispatch problem when demand is flexible, i.e., can be adjusted by the system. For example, the system operator may contact the industry to enforce a decrease of production. Include a benefit (such a benefit is usually referred to the `utility` of consumers) of being able to serve demand, assuming that this benefit is proportional to the amount of demand served. Is demand a parameter or a variable? Is this problem feasible for any data set?
"

# ╔═╡ 727b6e9e-ef77-11ea-2b63-21b8b91abd31
md"""
!!! hint "Solution 👀"
    Social costs minimization:
    
    ```math
    \begin{aligned}
    \min & \sum_{i=1}^{I} \sum_{t=1}^{T} a_{i}p_{i t} - \sum_{t=1}^T bd_t &\\
    \text {s.t. } & p_{i}^{\min } \leq p_{i t} \leq p_{i}^{\max } &\qquad \forall i \in I,\ \forall t \in T\\
    & \sum_{i=1}^{I} p_{i t} = d_{t}&\qquad \forall t \in T\\
    & p_{i t}, d_t \geq 0&\qquad \forall i \in I,\ \forall t \in T
    \end{aligned}
    ```

    Or equivalently social welfare maximization:
    ```math
    \begin{aligned}
    \max & \sum_{i=1}^{I} \sum_{t=1}^{T} \left(p_t - a_{i}\right)p_{i t} + \sum_{t=1}^T \left(b - p\right)d_t &\\
    \text {s.t. } & p_{i}^{\min } \leq p_{i t} \leq p_{i}^{\max } &\qquad \forall i \in I,\ \forall t \in T\\
    & \sum_{i=1}^{I} p_{i t} = d_{t}&\qquad \forall t \in T\\
    & p_{i t}, d_t \geq 0&\qquad \forall i \in I,\ \forall t \in T
    \end{aligned}
    ```
"""

# ╔═╡ 12145486-f923-11ea-2f8e-036ec37a9f87
md"
## Exercise 12

Reformulate the demand constraint of the economic dispatch problem to account for the integration of run-of river hydro-power $p_t^{hydro}$ , solar $p_t^{solar}$, tidal $p_t^{tidal}$ and wave power $p_t^{wave}$ . Is run-of river hydro-power, solar, tidal and wave power production paramters or decision variables in the problem? Why?
"

# ╔═╡ 64cd5132-f923-11ea-2818-d355cf1c13ab
md"""
!!! hint "Solution 👀"
    $$\sum_{i=1}^I p_{it} = d_t - p_t^{wind} - p_t^{hydro} - p_t^{solar} - p_t^{tidal} - p_t^{wave}$$
    All of them are parameters since production is non-controllable (there are no decisions to be made).
"""

# ╔═╡ d586c278-f923-11ea-33af-1d7dbbd9ae2f
md"
## Exercise 13

Assume that wind power curtailment, i.e., a reduction of the wind power generation, is possible at a cost of, say, $a^{wind}$. Adapt the economic dispatch problem to take this into account.
"

# ╔═╡ f0c92578-f923-11ea-1c50-537ffdf4476e
md"""
!!! hint "Solution 👀"
    ```math
    \begin{aligned}
    \min \sum_{i=1}^{I} &\sum_{t=1}^{T} a_{i} p_{i t}+\sum_{t=1}^{T} a^{\text {wind}} p_{t}^{\text {wind},-} &\qquad\\
    \text {st } p_{i}^{\min } &\leq p_{i t} \leq p_{i}^{\max } &\qquad \forall i \in I,\ \forall t \in T\\
    \sum_{i=1}^{I} p_{i t} &= d_{t}-\left(p_{t}^{w i n d}-p_{t}^{w i n d,-}\right) &\qquad \forall t \in T\\
    p_{t}^{\text {wind},-} &\leq p_{t}^{\text {wind}} &\qquad \forall t \in T\\
    p_{i t}, p_{t}^{w i n d,-} &\geq 0 &\qquad \forall i \in I,\ \forall t \in T
    \end{aligned}
    ```
    where $p_t^{wind, -}$ is the reduction or curtailment of wind power in period t, and $a^{wind}$ is the cost of curtailment.
"""

# ╔═╡ b63864f0-ef76-11ea-0ba7-f331f3f5d767
md"
## Notes:
"

# ╔═╡ a360fdf0-edce-11ea-2f42-07bd9073048a
author = (name = "Jorge Montalvo Arvizu", id = "s192184")

# ╔═╡ 7698a280-edcb-11ea-3048-7f291d85476f
md"""
# Module 3 - The economic dispatch problem ⚡📈💰

_42002 - Modelling and analysis of Sustainable Energy Systems using Operations Research_

Prepared by: **_$(author.name)_** ($(author.id)@student.dtu.dk)

### Exercises 📚
---

Solve the following exercises from 	`Hillier, Lieberman. Introduction to Operations Research, Eight Edition. pp. 91-95`, and from the course notes `Mathematical programming models for energy system analysis: An introduction. pp. 26-30`.

- HL:

  - 3.4 - 4


- Course notes:

  - 1 (excluding f)
  - 2
  - 5
  - 6
  - 12
  - 13
"""

# ╔═╡ Cell order:
# ╟─b31a8560-f132-11ea-2567-ffd1936707d4
# ╟─7698a280-edcb-11ea-3048-7f291d85476f
# ╟─e53fab60-ee9e-11ea-0602-456fbb0afe8e
# ╟─64223ee0-eea2-11ea-278b-ed5d31ebfe83
# ╟─24606590-ef54-11ea-22ae-939492342184
# ╟─1be9eb68-f905-11ea-0097-372fc9887503
# ╟─b2dd82b0-f46f-11ea-079b-376595f80407
# ╟─f06c1500-ee9e-11ea-3485-5d8ebf946aae
# ╟─68ad3570-ef77-11ea-1ae9-cb0c85fffac0
# ╟─bb61b24a-f911-11ea-27b7-997c31ecf3d1
# ╟─ccd2b7ba-f912-11ea-0b59-15c824b2afdc
# ╟─fe2a6cc0-eea1-11ea-0642-8735d6ad8a43
# ╟─6bea5f10-ef77-11ea-1181-1356c9b3b4e7
# ╟─2b4bcf90-eea3-11ea-0a5b-c5507c28ed4e
# ╟─6ef52e10-ef77-11ea-0e6c-356bdd085208
# ╟─f7931ed0-eea5-11ea-038b-75467446c7a9
# ╟─727b6e9e-ef77-11ea-2b63-21b8b91abd31
# ╟─12145486-f923-11ea-2f8e-036ec37a9f87
# ╟─64cd5132-f923-11ea-2818-d355cf1c13ab
# ╟─d586c278-f923-11ea-33af-1d7dbbd9ae2f
# ╟─f0c92578-f923-11ea-1c50-537ffdf4476e
# ╟─b63864f0-ef76-11ea-0ba7-f331f3f5d767
# ╟─a360fdf0-edce-11ea-2f42-07bd9073048a
# ╟─e96ee5ce-ef51-11ea-18f7-5fffcbe97c21
