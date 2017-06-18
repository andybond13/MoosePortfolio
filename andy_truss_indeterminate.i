#
# Truss in two dimensional space
#
#Hibbeler - Structural Analysis, 6th edition 10-27

[Mesh]
  type = FileMesh
  file = mesh/truss-indeterminate.msh
  displacements = 'disp_x disp_y'
[]

[Variables]
  [./disp_x]
    order = FIRST
    family = LAGRANGE
  [../]
  [./disp_y]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[AuxVariables]
  [./axial_stress]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./e_over_l]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./area]
    order = CONSTANT
    family = MONOMIAL
#    initial_condition = 1.0
  [../]
  [./react_x]
    order = FIRST
    family = LAGRANGE
  [../]
  [./react_y]
    order = FIRST
    family = LAGRANGE
  [../]
  [./react_z]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[Functions]
  [./x2]
    type = PiecewiseLinear
    x = '0  1 2 3'
    y = '0 .5 1 1'
  [../]
  [./y2]
    type = PiecewiseLinear
    x = '0 1  2 3'
    y = '0 0 .5 1'
  [../]
[]

[BCs]
  [./fixy1]
    type = DirichletBC
    variable = disp_y
    boundary = 1
    value = 0
  [../]

  [./fixx4]
    type = DirichletBC
    variable = disp_x
    boundary = 4
    value = 0
  [../]
  [./fixy4]
    type = DirichletBC
    variable = disp_y
    boundary = 4
    value = 0
  [../]
[]

[DiracKernels]
  [./load1]
    type = ConstantPointSource
    value = -6
    point = '48 0 0'
    variable = disp_x
  [../]
  [./load2]
    type = ConstantPointSource
    value = -8
    point = '48 36 0'
    variable = disp_y
  [../]
[]

[AuxKernels]
  [./axial_stress]
    type = MaterialRealAux
    block = '1 2 3 4 5 6'
    property = axial_stress
    variable = axial_stress
  [../]
  [./e_over_l]
    type = MaterialRealAux
    block = '1 2 3 4 5 6'
    property = e_over_l
    variable = e_over_l
  [../]
  [./area-thin]
    type = ConstantAux
    block = '1 3 4 6'
    variable = area
    value = 1.0
    execute_on = 'initial timestep_begin'
  [../]
  [./area-thick]
    type = ConstantAux
    block = '2 5' 
    variable = area
    value = 2.0
    execute_on = 'initial timestep_begin'
  [../]
[]

[Preconditioning]
  [./SMP]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type = Transient

  solve_type = PJFNK

  petsc_options_iname = '-pc_type -ksp_gmres_restart'
  petsc_options_value = 'jacobi   101'

  nl_max_its = 15
  nl_rel_tol = 1e-8
  nl_abs_tol = 1e-8
  end_time = 1.0
  dt = 0.1
[]

[Kernels]
  [./solid_x]
    type = StressDivergenceTensorsTruss
    block = '1 2 3 4 5 6'
    displacements = 'disp_x disp_y'
    component = 0
    variable = disp_x
    area = area
    save_in = react_x
    use_displaced_mesh = true
  [../]
  [./solid_y]
    type = StressDivergenceTensorsTruss
    block = '1 2 3 4 5 6'
    displacements = 'disp_x disp_y'
    component = 1
    variable = disp_y
    area = area
    save_in = react_y
    use_displaced_mesh = true
  [../]
[]

[Materials]
  [./linelast]
    type = LinearElasticTruss
    block = '1 2 3 4 5 6'
    youngs_modulus = 29e3
    displacements = 'disp_x disp_y'
#    formulation = nonlinear3d
  [../]
#    [./elasticity_tensor]
#      type = ComputeIsotropicElasticityTensor
#      block = '1 2 3 4 5 6'
#      youngs_modulus = 29e3
#      poissons_ratio = 0.3
#    [../]
#    [./strain]
#      type = ComputeFiniteStrain
#      block = '1 2 3 4 5 6'
#      displacements = 'disp_x disp_y'
#    [../]
#    [./stress]
#      type = ComputeFiniteStrainElasticStress
#      block = '1 2 3 4 5 6'
#    [../]
[]

[Outputs]
  exodus = true
[]
