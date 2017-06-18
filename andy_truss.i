#
# Truss in two dimensional space
#
#Hibbeler - Structural Analysis, 6th edition 3-39

[Mesh]
  type = FileMesh
  file = mesh/truss.msh
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
  [./fixx1]
    type = DirichletBC
    variable = disp_x
    boundary = 1
    value = 0
  [../]
  [./fixy1]
    type = DirichletBC
    variable = disp_y
    boundary = 1
    value = 0
  [../]

  [./fixy9]
    type = DirichletBC
    variable = disp_y
    boundary = 9
    value = 0
  [../]

[]

[DiracKernels]
  [./load1]
    type = ConstantPointSource
    value = -2
    point = '4 0 0'
    variable = disp_y
  [../]
  [./load2]
    type = ConstantPointSource
    value = -5
    point = '8 0 0'
    variable = disp_y
  [../]
  [./load3]
    type = ConstantPointSource
    value = -3
    point = '10 0 0'
    variable = disp_y
  [../]
  [./load4]
    type = ConstantPointSource
    value = -2
    point = '12 0 0'
    variable = disp_y
  [../]
[]

[AuxKernels]
  [./axial_stress]
    type = MaterialRealAux
    block = 30
    property = axial_stress
    variable = axial_stress
  [../]
  [./e_over_l]
    type = MaterialRealAux
    block = 30
    property = e_over_l
    variable = e_over_l
  [../]
  [./area]
    type = ConstantAux
    block = 30
    variable = area
    value = 0.8
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
  type = Steady

  solve_type = PJFNK

  petsc_options_iname = '-pc_type -ksp_gmres_restart'
  petsc_options_value = 'jacobi   101'

  nl_max_its = 15
  nl_rel_tol = 1e-8
  nl_abs_tol = 1e-8

[]

[Kernels]
  [./solid_x]
    type = StressDivergenceTensorsTruss
    block = 30
    displacements = 'disp_x disp_y'
    component = 0
    variable = disp_x
    area = area
    save_in = react_x
  [../]
  [./solid_y]
    type = StressDivergenceTensorsTruss
    block = 30
    displacements = 'disp_x disp_y'
    component = 1
    variable = disp_y
    area = area
    save_in = react_y
  [../]
[]

[Materials]
  [./linelast]
    type = LinearElasticTruss
    block = 30
    youngs_modulus = 1e6
    displacements = 'disp_x disp_y'
  [../]
[]

[Outputs]
  exodus = true
[]
