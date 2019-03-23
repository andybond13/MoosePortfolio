[Mesh]
  type = FileMesh
  file = test_gmsh.msh 
  #file = test.msh 
  displacements = 'disp_x disp_y disp_z'
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
  [./disp_z]
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
  [./z6]
    type = PiecewiseLinear
    x = '0  1 2 3'
    y = '0 .5 1 1'
  [../]
[]

[BCs]
  [./fix1_x]
    type = DirichletBC
    variable = disp_x
    boundary = 1001
    value = 0.0
  [../]
  [./fix1_y]
    type = DirichletBC
    variable = disp_y
    boundary = 1001
    value = 0.0
  [../]
  [./fix1_z]
    type = DirichletBC
    variable = disp_z
    boundary = 1001
    value = 0.0
  [../]

  [./fix2_x]
    type = DirichletBC
    variable = disp_x
    boundary = 1002
    value = 0.0
  [../]
  [./fix2_y]
    type = DirichletBC
    variable = disp_y
    boundary = 1002
    value = 0.0
  [../]
  [./fix2_z]
    type = DirichletBC
    variable = disp_z
    boundary = 1002
    value = 0.0
  [../]

  [./fix3_x]
    type = DirichletBC
    variable = disp_x
    boundary = 1003
    value = 0.0
  [../]
  [./fix3_y]
    type = DirichletBC
    variable = disp_y
    boundary = 1003
    value = 0.0
  [../]
  [./fix3_z]
    type = DirichletBC
    variable = disp_z
    boundary = 1003
    value = 0.0
  [../]

  [./fix4_z]
    type = FunctionDirichletBC
    variable = disp_z
    boundary = 1004
    function = z6 
  [../]
[]

[AuxKernels]
  [./axial_stress]
    type = MaterialRealAux
    property = axial_stress
    variable = axial_stress
  [../]
  [./e_over_l]
    type = MaterialRealAux
    property = e_over_l
    variable = e_over_l
  [../]
  [./area]
    type = ConstantAux
    variable = area
    value = 1.0
    execute_on = 'initial timestep_begin'
  [../]
[]

[Executioner]
  type = Transient
  solve_type = PJFNK
  petsc_options_iname = '-pc_type -ksp_gmres_restart'
  petsc_options_value = 'jacobi   101'
  line_search = 'none'

  nl_max_its = 15
  nl_rel_tol = 1e-6
  nl_abs_tol = 1e-10

  dt = 1
  num_steps = 3
  end_time = 3
[]

[Kernels]
  [./solid_x]
    type = StressDivergenceTensorsTruss
    component = 0
    variable = disp_x
    area = area
    save_in = react_x
  [../]
  [./solid_y]
    type = StressDivergenceTensorsTruss
    component = 1
    variable = disp_y
    area = area
    save_in = react_y
  [../]
  [./solid_z]
    type = StressDivergenceTensorsTruss
    component = 2
    variable = disp_z
    area = area
    save_in = react_z
  [../]
[]

[Materials]
  [./linelast]
    type = LinearElasticTruss
    youngs_modulus = 1e6
    displacements = 'disp_x disp_y disp_z'
#    thermal_expansion_coeff = 0.1
#    temperature_ref = 0.5
#    temperature = temp
  [../]
[]

[Outputs]
  exodus = true
[]
