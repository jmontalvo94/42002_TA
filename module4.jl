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
	using LinearAlgebra
	using Plots
	using PlutoUI
end

# ╔═╡ b31a8560-f132-11ea-2567-ffd1936707d4
html"<button onclick=present()>Present</button>"

# ╔═╡ e53fab60-ee9e-11ea-0602-456fbb0afe8e
md"
## $3.1-6.$

The Whitt Window Company is a company with only three employees which makes two different kinds of hand-crafted windows: a wood-framed and an aluminum-framed window. They earn $60 profit for each wood-framed window and $30 profit for each aluminum-framed window. Doug makes the wood frames, and can make 6 per day. Linda makes the aluminum frames, and can make 4 per day. Bob forms and cuts the glass, and can make 48 square feet of glass per day. Each wood-framed window uses 6 square feet of glass and each aluminum-framed window uses 8 square feet of glass.

The company wishes to determine how many windows of each type to produce per day to maximize total profit.

**a)** Describe the analogy between this problem and the Wyndor Glass Co. problem discussed in Sec. 3.1. Then construct and fill in a table like Table 3.1 for this problem, identifying both the activities and the resources.

**(b)** Formulate a linear programming model for this problem.

**(c)** Use the graphical method to solve this model.

**d)** A new competitor in town has started making wood-framed windows as well. This may force the company to lower the price they charge and so lower the profit made for each woodframed window. How would the optimal solution change (if at all) if the profit per wood-framed window decreases from $60 to $40? From $60 to $20?


**e)** Doug is considering lowering his working hours, which would decrease the number of wood frames he makes per day. How would the optimal solution change if he makes only 5 wood frames per day?
"

# ╔═╡ 64223ee0-eea2-11ea-278b-ed5d31ebfe83
md"""
!!! hint "Solution 👀"
    **a)** Both problems have limited resources (plants hours in the Wyndor problem, man-hour in this one) shared by a number of activities (production of windows/doors in both problems). Both problems can be formulated using the Standard Form.

    **b)** 
    ```math
    \begin{align}
    \text{ Min } \quad &Z = 60x_1 + 30x_2\\
    \text{ s.t. } \quad &x_1 \leq 6\\
    &x_2 \leq 4\\
    &6x_1 + 8x_2 \leq 48 \\
    &x_1 \geq 0,\ x_2 \geq 0 \\
    \end{align}
    ```
 
    **c)** Solution:

    ```math
    \begin{align}
    x_1 &= 6\\
    x_2 &= 1.5\\
    Z &= 405
    \end{align}
    ```

    **d)** If the profit per wooden window drops to \$40 the optimal solution remains $(6, 1.5)$ but the objective value decreases to $Z = 285$. If the profit drops to \$20 per unit the optimal solution becomes $(\frac{8}{3}, 4)$ with $Z = 173.33$.

    Observe how the slope of the objective function changes by changing the profit of the wooden window. Particularly observe how the slope changes with respect to the slope of constraint boundary $6x_1+8x_2 = 48$. Notice that when the profit is $20, the slope of the objective function is greater than the slope of the constraint boundary, whereas in the other cases it is smaller.

    **e)** Solution:

    ```math
    \begin{align}
    x_1 &= 5\\
    x_2 &= 2.25\\
    Z &= 367.5
    \end{align}
    ```

    Observe what happens graphically to the first constraint, and how the feasible region shrinks.
"""

# ╔═╡ 24606590-ef54-11ea-22ae-939492342184
md"""
### Graphical solution
---

``Z=c_1x_1+30x_2``: $(@bind obj CheckBox())

``x_1 \leq w_d``: $(@bind c1 CheckBox())

``x_2 \leq 4``: $(@bind c2 CheckBox())

``6x_1 + 8x_2 \leq 48``: $(@bind c3 CheckBox())

``Z`` = $(@bind Z Slider(150:1:405, default=300, show_value=true))

``c_1`` (wood-frame profit): $(@bind profit Select(["60" => 60, "40" => 40, "20" => 20]))

``w_d`` (Doug wood-frames): $(@bind w_d Select(["6" => 6, "5" => 5]))

"""

# ╔═╡ 1be9eb68-f905-11ea-0097-372fc9887503
begin
	lims = [(0, 8), (0, 8), (350, 450)]
	xlims, ylims, zlims = lims[1], lims[2], lims[3]
	
	plot(widen=false)
	
	if c1 && w_d == "6"
		plot!([6, 6], [ylims[1], ylims[2]], fillrange=0, fillalpha=0.1,label=L"$x_1 \leq 6$")
		plot!([xlims[1], 6], [ylims[2], ylims[2]], fillrange=0, fillalpha=0.1, color="lightblue", label=nothing, line=nothing)
	elseif c1 && w_d == "5"
		plot!([5, 5], [ylims[1], ylims[2]], fillrange=0, fillalpha=0.1,label=L"$x_1 \leq 5$")
		plot!([xlims[1], 5], [ylims[2], ylims[2]], fillrange=0, fillalpha=0.1, color="lightblue", label=nothing, line=nothing)
	end
	if c2
		plot!([xlims[1], xlims[2]],[4, 4], fillrange=0, fillalpha=0.1, label=L"$x_2 \leq 4$")
	end
	if c3
		plot!([0, 48/6],[48/8, 0], fillrange=0, fillalpha=0.1, label=L"$6x_1 + 8x_2 \leq 48$")
	end
	
	if obj && profit == "60"
		plot!([0,Z/parse(Int, profit)],[Z/30,0], label=L"$Z=60x_1+30x_2$", color=:red, linestyle=:dash, linewidth=1)
	elseif obj && profit == "40"
		plot!([0,Z/parse(Int, profit)],[Z/30,0], label=L"$Z=40x_1+30x_2$", color=:red, linestyle=:dash, linewidth=1)
	elseif obj && profit == "20"
		plot!([0,Z/parse(Int, profit)],[Z/30,0], label=L"$Z=20x_1+30x_2$", color=:red, linestyle=:dash, linewidth=1)
	end
	
	if w_d == "6"
		if obj && Z == 405 && profit == "60"
			scatter!([6], [1.5], color="red", label="Optimal solution")
			annotate!((5.5, 1, text("Optimal solution (6, 1.5)", :right)))
		elseif obj && Z == 285 && profit == "40"
			scatter!([6], [1.5], color="red", label="Optimal solution")
			annotate!((5.5, 1, text("Optimal solution (6, 1.5)", :right)))
		elseif obj && (Z == 173 || Z == 174) && profit == "20"
			scatter!([8/3], [4], color="red", label="Optimal solution")
			annotate!((8/3, 5, text("Optimal solution (8/3, 4)", :left)))
		end
	elseif w_d == "5"
		if obj && (Z == 367 || Z == 368) && profit == "60"
			scatter!([5], [2.25], color="red", label="Optimal solution")
			annotate!((4.5, 2, text("Optimal solution (5, 2.25)", :left)))
		elseif obj && (Z == 267 || Z == 268) && profit == "40"
			scatter!([5], [2.25], color="red", label="Optimal solution")
			annotate!((4.5, 2, text("Optimal solution (5, 2.25)", :left)))
		elseif obj && (Z == 173 || Z == 174) && profit == "20"
			scatter!([8/3], [4], color="red", label="Optimal solution")
			annotate!((8/3, 5, text("Optimal solution (8/3, 4)", :left)))
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

# ╔═╡ f06c1500-ee9e-11ea-3485-5d8ebf946aae
md"
## $4.1 - 7$

Describe graphically what the simplex method does step by step to solve the following problem:

```math
\begin{align}
\text{ Min } \quad &Z = 5x_1 + 7x_2\\
\text{ s.t. } \quad &2x_1 + 3x_2 \geq 42\\
&3x_1 + 4x_2 \geq 60\\
&x_1 + x_2 \geq 18 \\
&x_1 \geq 0,\ x_2 \geq 0 \\
\end{align}
```
"

# ╔═╡ 68ad3570-ef77-11ea-1ae9-cb0c85fffac0
md"""
!!! hint "Solution 👀"
    The simplex method starts from a CPF solution. Since the origin is not a CPF solution in this case, let us assume it starts from $(21, 0)$, with $Z = 105$. There are two options: moving along the $x_1$ axis or moving along the boundary of constraint $2x_1 + 3x_2 \geq 42$.

    To check the rate of change, take the dot-product of the representative vector for $z$: $\overrightarrow{z} = [5, 7]$ and the eigenvector of the constraint $\overrightarrow{a} = [-3, 2]/\sqrt{(-3)^2+2^2}$ and compare with the dot-product of the representative vector for $z$ and the $x_1 ([1, 0])$. Moving along the $x_1$ axis leads to a negative rate of improvement, i.e. higher objective value, and is therefore not improving the solution. Moving along $2x_1 + 3x_2 = 42$ gives a positive rate of improvement $(-1/\sqrt{13})$, so we continue in that direction until we meet the first constraint boundary which gives $(12, 6)$ with $Z = 102$.

    We check the rate of improvement in the direction of the constraint $x_1 + x_2 \geq 18$, by taking the dot-product of the representative z-vector and the eigenvector of following that constraint: $\overrightarrow{b} = [-1,1]/\sqrt{(-1)^2+1^2}$ and comparing to going back down on the constraint we used before. The dot-product in the new direction is $(2/\sqrt{2}) > 0$ in the direction where we came from, it is also positive $(1/\sqrt{13})$.

    There are no positive rate of improvement going, i.e. smaller objective value, along any of the boundaries, therefore the CPF solution $(12, 6)$ is optimal with $Z = 102$.
"""

# ╔═╡ bb61b24a-f911-11ea-27b7-997c31ecf3d1
md"""
### Graphical solution
---

``Z=5x_1+7x_2``: $(@bind obj_2 CheckBox())

``2x_1 + 3x_2 \geq 42``: $(@bind c1_2 CheckBox())

``3x_1 + 4x_2 \geq 60``: $(@bind c2_2 CheckBox())

``x_1 + x_2 \geq 18``: $(@bind c3_2 CheckBox())

``Z`` = $(@bind Z_2 Slider(80:1:120, default=105, show_value=true))
"""

# ╔═╡ 23cea264-febc-11ea-3ef3-05bd2b6a4743
begin
	lims2 = [(0, 21), (0, 21), (350, 450)]
	xlims2, ylims2, zlims2 = lims2[1], lims2[2], lims2[3]
	
	plot(widen=false)
	
	if c1_2
		plot!([0, 42/2], [42/3, 0], fillrange=100, fillalpha=0.1,label=L"$2x_1 + 3x_2 \geq 42$")
	end
	if c2_2
		plot!([0, 21],[60/4, -3/4], fillrange=100, fillalpha=0.1, label=L"$3x_1 + 4x_2 \geq 60$")
	end
	if c3_2
		plot!([0, 21],[18, -3], fillrange=100, fillalpha=0.1, label=L"$x_1 + x_2 \geq 18$")
	end
	
	if obj_2
		plot!([0,Z_2/5],[Z_2/7,0], label=L"$Z=5x_1+7x_2$", color=:red, linestyle=:dash, linewidth=1)
	end
	
	if obj_2 && Z_2 == 102
		scatter!([12], [6], color="red", label="Optimal solution")
		annotate!((12, 4, text("Optimal solution (12, 6)", :left)))
	end

	
	xlims!(xlims2)
	ylims!(ylims2)
	xlabel!(L"$x_1$")
	ylabel!(L"$x_2$")
end

# ╔═╡ e1c6560a-fed9-11ea-2449-b3b4ba232b4b
md"
_Note that the feasible regions for_ $x_1 \geq 0$ _and_ $x_2 \geq 0$ _are not shown/colored._
"

# ╔═╡ 475d698a-fec2-11ea-112f-2d21929fb57d
md"""
### Dot-product
---

``\overrightarrow{z} [5, 7]``: $(@bind z_v CheckBox())

``\overrightarrow{a} [-3, 2]``: $(@bind a_v CheckBox())

``\overrightarrow{b} [-1, 1]``: $(@bind b_v CheckBox())

"""

# ╔═╡ 48f57a8e-febe-11ea-0337-3344672b2d90
begin
	z = [5, 7]
	a = [-3,2]/sqrt((-3)^2+2^2)
	b = [-1,1]/sqrt((-1)^2+1^2)
	
	scatter([0], [0], color="black", label=nothing)
	annotate!((0.2, -0.5, text("Origin", :left)))
	
	if z_v
		quiver!([0],[0],quiver=([z[1]],[z[2]]), label="Z")
	end
	if a_v
		quiver!([0],[0],quiver=([-3],[2]), label="a")
		quiver!([0],[0],quiver=([a[1]],[a[2]]), label="a")
	end
	if b_v
		quiver!([0],[0],quiver=([-1],[1]), label="a")
		quiver!([0],[0],quiver=([b[1]],[b[2]]), label="b")
	end
	
	xlabel!(L"$x_1$")
	ylabel!(L"$x_2$")
	xlims!(-5,8)
	ylims!(-5,8)
end

# ╔═╡ 313ecaa4-fec2-11ea-164e-dd0bebe60614
md"
Rembember from linear algebra that $r \cdot s = |r|\ |s|\ cos\ \theta$, i.e. the dot product is a product of lengths of vectors in the same direction. 

When the angle between them is $0$, then $cos (0) = 1$, and $r \cdot s = |r|\ |s|\ * 1$. 

When the angle is $90$, then $cos (90) = 0$, and $r \cdot s = |r|\ |s|\ * 0 = 0$. 
"

# ╔═╡ 8b2a9e80-fed1-11ea-040e-17f557cde0c4
a # already eigenvector

# ╔═╡ d1595504-fecc-11ea-29b5-335fd1b59b80
b # already eigenvector

# ╔═╡ 15884ef8-fec1-11ea-053e-af21203b3101
dot(z,a) # product of lengths of vectors in the same direction

# ╔═╡ b1f46b26-fec3-11ea-0e73-2f53f531f587
dot(z,b) # product of lengths of vectors in the same direction

# ╔═╡ 885afef4-fed4-11ea-0f2d-23861fde3fba
norm(a) # length

# ╔═╡ 8b92cb68-fed4-11ea-2f57-c9f297bc4327
norm(b) # length (floating point error ≈ 1)

# ╔═╡ 2aa7222e-fed4-11ea-13df-1336b0df6cb8
theta_a = acos(dot(z,a)/(norm(z)*norm(a))) # theta in radians (91.85°)

# ╔═╡ 54c143f0-fed4-11ea-2419-fb3e0ff68a74
theta_b = acos(dot(z,b)/(norm(z)*norm(b))) # theta in radians (91.85°)

# ╔═╡ 38cb172e-fed5-11ea-0606-2bee131f503d
norm(a)*cos(theta_a) # projection of a on z

# ╔═╡ 3e2728fc-fed5-11ea-172d-b548bdd6adfc
norm(b)*cos(theta_b) # projection of b on z

# ╔═╡ 6227735c-fed4-11ea-209a-9b6fb0bac9ee
norm(z)*norm(a)*cos(theta_a) # product of lengths of vectors in the same direction

# ╔═╡ 73a8ee3a-fed4-11ea-1b13-bb79cbd2c0ee
norm(z)*norm(b)*cos(theta_b) # product of lengths of vectors in the same direction

# ╔═╡ fe2a6cc0-eea1-11ea-0642-8735d6ad8a43
md"
## $6.1 - 3$

For each of the following linear programmings models, give your recommendation on which is the more efficient way (probably) to obtain an optimal solution: by applying the simplex method directly to this primal problem or by applying the simplex method directly to the dual problem instead. Explain.

**a)**
```math
\begin{align}
\text{ Max } \quad &Z = 10x_1-4x_2+7x_3\\
\text{ s.t. } \quad &3x_1 - x_2 + 2x_3 \leq 25\\
&x_1-2x_2+3x_3\leq25\\
&5x_1 + x_2 + 2x_3 \leq 40\\
&x_1 + x_2 + x_3 \leq 90\\
&2x_1 - x_2 + x_3 \leq 20\\
&x_1 \geq 0,\ x_2 \geq 0,\ x_3 \geq 0 \\
\end{align}
```

**b)**
```math
\begin{align}
\text{ Max } \quad &Z = 2x_1+5x_2+3x_3+4x_4+x_5\\
\text{ s.t. } \quad &x_1+3x_2+2x_3+3x_4+x_5 \leq 6\\
&4x_1 + 6x_2 + 5x_3 + 7x_4 + x_5 \leq 15\\
&x_j \geq 0,\ \forall j \in [1,5]\\
\end{align}
```
"

# ╔═╡ 6bea5f10-ef77-11ea-1181-1356c9b3b4e7
md"""
!!! hint "Solution 👀"
    **a)** The dual = fewer constraints

    **b)** The primal = fewer constraints
"""

# ╔═╡ 2b4bcf90-eea3-11ea-0a5b-c5507c28ed4e
md"
## $6.1 - 5$

Consider the following problem:

```math
\begin{align}
\text{ Max } \quad &Z = 2x_1 + 6x_2 + 9x_3&\\
\text{ s.t. } \quad &x_1 + x_3 \leq 3\qquad &(\text{resource} 1)\\
&x_2 + 2x_3 \leq 5\qquad &(\text{resource} 2)\\
&x_1 \geq 0,\ x_2 \geq 0,\ x_3 \geq 0 & \\
\end{align}
```

**a)** Construct the dual problem for this primal problem.

**b)** Solve the dual problem graphically. Use this solution to identify the shadow prices for the resources in the primal problem.

**c)** Verify your solution by finding the optimal solution to the primal problem by guessing. Can you find a solution to the primal problem with the same objective value as the dual problem? What happens if resource 1 is increased by one unit (from 3 to 4)? What if it is decreased by one unit?
"

# ╔═╡ 6ef52e10-ef77-11ea-0e6c-356bdd085208
md"""
!!! hint "Solution 👀"
    **a)**
    ```math
    \begin{align}
    \text{ Min } \quad &W = 3y_1 + 5y_2\\
    \text{ s.t. } \quad &y_1 \geq 2\\
    &y_2 \geq 6\\
    &y_1 + 2y_2 \geq 9 \\
    &y_1 \geq 0,\ y_2 \geq 0 \\
    \end{align}
    ```
    **b)**
    ```math
    \begin{align}
    y_1 &= 2\\
    y_2 &= 6\\
    W &= 36\\
    \end{align}
    ```
    The shadow price for resource 1 is $y_1$ and for resource 2 is $y_2$.

    **c)** Guess:
    ```math
    \begin{align}
    x_1 &= 3\\
    x_2 &= 5\\
    x_3 &= 0\\
    Z &= 36\\
    \end{align}
    ```
    Which has the same objective as the dual and is therefore the optimal solution. Or: If $y_1$ and $y_2 > 0$ then constraints 1 and 2 are binding, meaning that $x_1 + x_3 = 3$ and $x_2 + 2x_3 = 5$.

    Further, we know that the objective function of the primal problem equals the dual problem's, and we therefore have a system of three equations with three unknowns. Isolate for instance $x_1$ and $x_2$ in the two binding constraints and use them in the objective:
    ```math
    \begin{align}
    x_1 +x_3 = 3 &\Leftrightarrow x_1 = 3 - x_3\\
    x_2 + 2x_3 = 5 &\Leftrightarrow x_2 = 5 - 2x_3\\
    Z = 2(3-x_3)+6(5-2x_3)+9x_3 = 36 &\Leftrightarrow x_3 = 0\\
    x_1 &= 3\\
    x_2 &= 5\\
    \end{align}
    ```
    The objective value will increase if capacity of resource 1 is increased, and it is decreased if the capacity is decreased. The increase/decrease will be equal to the shadow price of resource 1.
"""

# ╔═╡ a62456ec-fed9-11ea-2816-fd832d1a3025
md"""
### Graphical solution
---

``W=3y_1 + 5y_2``: $(@bind obj_3 CheckBox())

``y_1 \geq 2``: $(@bind c1_3 CheckBox())

``y_2 \geq 6``: $(@bind c2_3 CheckBox())

``y_1 + 2y_2 \geq 9``: $(@bind c3_3 CheckBox())

``W`` = $(@bind W Slider(21:3:45, default=30, show_value=true))
"""

# ╔═╡ 125713cc-feda-11ea-3f2a-95a2b1791ba5
begin
	lims3 = [(0, 9), (0, 9), (21, 45)]
	xlims3, ylims3, zlims3 = lims3[1], lims3[2], lims3[3]
	
	plot(widen=false)
	
	if c1_3
		plot!([2, 2], [0, ylims3[2]], fillrange=0, fillalpha=0.1,label=L"$y_1 \geq 2$")
		plot!([2, xlims3[2]], [ylims3[2], ylims3[2]], fillrange=0, fillalpha=0.1,label=nothing, color="lightblue", line=nothing)
	end
	if c2_3
		plot!([0, xlims3[2]],[6, 6], fillrange=100, fillalpha=0.1, label=L"$y_2 \geq 6$")
	end
	if c3_3
		plot!([0, 9],[9/2, 0], fillrange=100, fillalpha=0.1, label=L"$y_1 + 2y_2 \geq 9$")
	end
	
	if obj_3
		plot!([0,W/3],[W/5,0], label=L"$W=3y_1 + 5y_2$", color=:red, linestyle=:dash, linewidth=1)
	end
	
	if obj_3 && W == 36
		scatter!([2], [6], color="red", label="Optimal solution")
		annotate!((2.5, 6.5, text("Optimal solution (2, 6)", :left)))
	end

	
	xlims!(xlims3)
	ylims!(ylims3)
	xlabel!(L"$y_1$")
	ylabel!(L"$y_2$")
end

# ╔═╡ e86e085e-fed9-11ea-3b13-67dd97e800b9
md"
_Note that the feasible regions for_ $y_1 \geq 0$ _and_ $y_2 \geq 0$ _are not shown/colored._
"

# ╔═╡ f7931ed0-eea5-11ea-038b-75467446c7a9
md"
## Exercise $1$

Consider the economic dispatch problem for a very small power system with only two units, Unit 1 and Unit 2. 

**a)** Unit 1 is a coal-fired steam unit with minimum and maximum generation levels of 150 MW and 350 MW and production costs of 600 Euro/MW. Unit 2 is a oil-fired steam unit with minimum and maximum generation levels of 50 MW and 500 MW and production costs of 900 Euro/MW. Demand is 600 MW.

**f)** Consider the problem from a). State its dual problem, solve this by inspection and use it to find the shadow price of electricity. Could you have found this price in another way?
"

# ╔═╡ 727b6e9e-ef77-11ea-2b63-21b8b91abd31
md"""
!!! hint "Solution 👀"
    ```math
    \begin{align}
    \text{ Max } \quad &150y_1 + 350y_2 + 50y_3 + 500y_4 + 600y_5\\
    \text{ s.t. } \quad &y_1 +y_2 + y_5 \leq 600\\
    &y_3 + y_4 + y_5 \leq 900\\
    &y_1 \geq 0,\ y_2 \leq 0,\ y_3 \geq 0\\
    &y_4 \leq 0,\ y_5\ \text{is free}
    \end{align}
    ```
    Looking at the dual problem, following can be seen:
    
    ``y_1^* = y_3^* = 0 \rightarrow`` it is better to increase ``y_5``

    if ``y_2 = 0 \Rightarrow y_5 = 600,\ y_4 = 300`` (not possible ``\rightarrow y_4 \leq 0``)

    if ``y_4 = 0 \Rightarrow y_5 = 900,\ y_2 = -200`` (possible)

    if ``y_5 = 0 \Rightarrow y_2 = 600,\ y_4 = 900`` (not possible ``\rightarrow y_2,\ y_4 \leq 0``)

    Hence, the best solution is ``y_2^* = -300,\ y_4^*=0,\ y_5^*=900``, where the shadow price of electricity is ``y_5^*=900``.
"""

# ╔═╡ 12145486-f923-11ea-2f8e-036ec37a9f87
md"
## $4.1 - 8$

Label each of the following statements about linear programming problems as true or false, and then justify your answer.

**a)** For minimization problems, if the objective function evaluated at a CPF solution is no larger than its value at every adjacent CPF solution, then that solution is optimal.

**b)** Only CPF solutions can be optimal, so the number of optimal solutions cannot exceed the number of CPF solutions.

**c)** If multiple optimal solutions exist, then an optimal CPF solution may have an adjacent CPF solution that also is optimal (the same value of Z).
"

# ╔═╡ 64cd5132-f923-11ea-2818-d355cf1c13ab
md"""
!!! hint "Solution 👀"
    **a)** True

    **b)** False

    **c)** True
"""

# ╔═╡ d586c278-f923-11ea-33af-1d7dbbd9ae2f
md"
## $6.1 - 7$

Consider the following problem:

```math
\begin{align}
\text{ Max } \quad &Z = x_1 + 2x_2&\\
\text{ s.t. } \quad &-x_1 + x_2 \leq -2\\
&4x_1 + x_2 \leq 4\\
&x_1 \geq 0,\ x_2 \geq 0\\
\end{align}
```

**a)** Demonstrate graphically that this problem has no feasible solutions.

**b)** Construct the dual problem.

**c)** Demonstrate graphically that the dual problem has an unbounded objective function.
"

# ╔═╡ f0c92578-f923-11ea-1c50-537ffdf4476e
md"""
!!! hint "Solution 👀"
    **b)**
    ```math
    \begin{align}
    \text{ Min } \quad &W = -2y_1 + 4y_2&\\
    \text{ s.t. } \quad &-y_1 + 4y_2 \geq 1\\
    &y_1 + y_2 \geq 2\\
    &y_1 \geq 0,\ y_2 \geq 0\\
    \end{align}
    ```
"""

# ╔═╡ b63864f0-ef76-11ea-0ba7-f331f3f5d767
md"
## Notes:
"

# ╔═╡ a360fdf0-edce-11ea-2f42-07bd9073048a
author = (name = "Jorge Montalvo Arvizu", id = "s192184")

# ╔═╡ 7698a280-edcb-11ea-3048-7f291d85476f
md"""
# Module 4 - Duality in Linear Programming 🌓🖖

_42002 - Modelling and analysis of Sustainable Energy Systems using Operations Research_

Prepared by: **_$(author.name)_** ($(author.id)@student.dtu.dk)

### Exercises 📚
---

Solve the following exercises from 	`Hillier, Lieberman. Introduction to Operations Research, Eight Edition. pp. 91-95, 162-163, and 276-277`, and from the course notes `Mathematical programming models for energy system analysis: An introduction. pp. 26`.

- HL:

  - 3.1 - 6
  - 4.1 - 7
  - 6.1 - 3
  - 6.1 - 5. Instead of c) you should verify your solution by finding the optimal solution to the primal problem by guessing. Can you find a solution to the primal problem with the same objective value as the dual problem? What happens if resource 1 is increased by one unit (from 3 to 4)? What if it is decreased by one unit?
  - 4.1 - 8 **(optional)**
  - 6.1 - 7 **(optional)**

- Course notes:
  - 1f)


- GAMS code from the lecture

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
# ╟─23cea264-febc-11ea-3ef3-05bd2b6a4743
# ╟─e1c6560a-fed9-11ea-2449-b3b4ba232b4b
# ╟─475d698a-fec2-11ea-112f-2d21929fb57d
# ╟─48f57a8e-febe-11ea-0337-3344672b2d90
# ╟─313ecaa4-fec2-11ea-164e-dd0bebe60614
# ╠═8b2a9e80-fed1-11ea-040e-17f557cde0c4
# ╠═d1595504-fecc-11ea-29b5-335fd1b59b80
# ╠═15884ef8-fec1-11ea-053e-af21203b3101
# ╠═b1f46b26-fec3-11ea-0e73-2f53f531f587
# ╠═885afef4-fed4-11ea-0f2d-23861fde3fba
# ╠═8b92cb68-fed4-11ea-2f57-c9f297bc4327
# ╠═2aa7222e-fed4-11ea-13df-1336b0df6cb8
# ╠═54c143f0-fed4-11ea-2419-fb3e0ff68a74
# ╠═38cb172e-fed5-11ea-0606-2bee131f503d
# ╠═3e2728fc-fed5-11ea-172d-b548bdd6adfc
# ╠═6227735c-fed4-11ea-209a-9b6fb0bac9ee
# ╠═73a8ee3a-fed4-11ea-1b13-bb79cbd2c0ee
# ╟─fe2a6cc0-eea1-11ea-0642-8735d6ad8a43
# ╟─6bea5f10-ef77-11ea-1181-1356c9b3b4e7
# ╟─2b4bcf90-eea3-11ea-0a5b-c5507c28ed4e
# ╟─6ef52e10-ef77-11ea-0e6c-356bdd085208
# ╟─a62456ec-fed9-11ea-2816-fd832d1a3025
# ╟─125713cc-feda-11ea-3f2a-95a2b1791ba5
# ╟─e86e085e-fed9-11ea-3b13-67dd97e800b9
# ╟─f7931ed0-eea5-11ea-038b-75467446c7a9
# ╟─727b6e9e-ef77-11ea-2b63-21b8b91abd31
# ╟─12145486-f923-11ea-2f8e-036ec37a9f87
# ╟─64cd5132-f923-11ea-2818-d355cf1c13ab
# ╟─d586c278-f923-11ea-33af-1d7dbbd9ae2f
# ╟─f0c92578-f923-11ea-1c50-537ffdf4476e
# ╟─b63864f0-ef76-11ea-0ba7-f331f3f5d767
# ╟─a360fdf0-edce-11ea-2f42-07bd9073048a
# ╟─e96ee5ce-ef51-11ea-18f7-5fffcbe97c21
