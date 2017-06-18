[Mesh]
#  displacements = 'disp_x disp_y disp_z' #Define displacements for deformed mesh
  type = FileMesh
  file = mesh/plateXY-2.msh 
  uniform_refine = 0
  boundary_id = '2 3 4 5' #Assign names to boundaries to make things clearer
  boundary_name = 'left right front back'
  block_id = '1'
  block_name = 'vol'
[]

[Variables]
  [./disp_x]
    block = 1
  [../]
  [./disp_y]
    block = 1
    scaling = 1
  [../]
  [./disp_z]
    block = 1
    scaling = 1
  [../]
  [./c]
    block = 1
    scaling = 1e1
  [../]
  [./b]
    block = 1
    scaling = 1e7
  [../]
[]

[AuxVariables]
  [./resid_x]
    block = 1
  [../]
  [./resid_y]
    block = 1
  [../]
  [./resid_z]
    block = 1
  [../]
  [./stress_max]
    #Dependent variable used to visualize the maximum principal stress
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_med]
    #Dependent variable used to visualize the medium principal stress
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_min]
    #Dependent variable used to visualize the minimum principal stress
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./von_mises]
    #Dependent variable used to visualize the Von Mises stress
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_xy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_xz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_yz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[Functions]
  [./tfunc]
    type = ParsedFunction
    value = t
  [../]
  [./velBC]
    type = ParsedFunction
    value = 'vx*t'
    vars = 'vx'
    vals = '0.01'
  [../]
[]

[Kernels]
  [./pfbulk]
    type = PFFracBulkRate
    variable = c
    block = 1
    l = 0.01
    beta = b
    visco =1e-4
    gc_prop_var = 'gc_prop'
    G0_var = 'G0_pos'
    dG0_dstrain_var = 'dG0_pos_dstrain'
    disp_x = disp_x
    disp_y = disp_y
    disp_z = disp_z
  [../]
  [./solid_x]
    type = StressDivergencePFFracTensors
    variable = disp_x
    displacements = 'disp_x disp_y disp_z'
    component = 0
    block = 1
    save_in = resid_x
    c = c
  [../]
  [./solid_y]
    type = StressDivergencePFFracTensors
    variable = disp_y
    displacements = 'disp_x disp_y disp_z'
    component = 1
    block = 1
    save_in = resid_y
    c = c
  [../]
  [./solid_z]
    type = StressDivergencePFFracTensors
    variable = disp_z
    displacements = 'disp_x disp_y disp_z'
    component = 2
    block = 1
    save_in = resid_z
    c = c
  [../]
  [./dcdt]
    type = TimeDerivative
    variable = c
    block = 1
  [../]
  [./pfintvar]
    type = PFFracIntVar
    variable = b
    block = 1
  [../]
  [./pfintcoupled]
    type = PFFracCoupledInterface
    variable = b
    c = c
    block = 1
  [../]
[]

[AuxKernels]
  [./max_prin_kernel]
    #Calculates the maximum principal stress 
    type = RankTwoScalarAux
    variable = stress_max
    rank_two_tensor = stress
    execute_on = timestep_end
    scalar_type = MaxPrincipal
  [../]
  [./med_prin_kernel]
    #Calculates the medium principal stress 
    type = RankTwoScalarAux
    variable = stress_med
    rank_two_tensor = stress
    execute_on = timestep_end
    scalar_type = MidPrincipal
  [../]
  [./min_prin_kernel]
    #Calculates the minimum principal stress 
    type = RankTwoScalarAux
    variable = stress_min
    rank_two_tensor = stress
    execute_on = timestep_end
    scalar_type = MinPrincipal
  [../]
  [./von_mises_kernel]
    #Calculates the von mises stress and assigns it to von_mises
    type = RankTwoScalarAux
    variable = von_mises
    rank_two_tensor = stress
    execute_on = timestep_end
    scalar_type = VonMisesStress
  [../]
  [./stress_xx]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xx
    index_i = 0
    index_j = 0
  [../]
  [./stress_xy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xy
    index_i = 0
    index_j = 1
  [../]
  [./stress_xz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xz
    index_i = 0
    index_j = 2
  [../]
  [./stress_yy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yy
    index_i = 1
    index_j = 1
  [../]
  [./stress_yz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yz
    index_i = 1
    index_j = 2
  [../]
  [./stress_zz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_zz
    index_i = 2
    index_j = 2
  [../]
[]

[BCs]
  [./anchor_x]
    #Anchors the left side against deformation in the x-direction 
    type = PresetBC
    variable = disp_x 
    boundary = 'left'
    value = 0.0 
  [../]
  [./right_x]
    #Moves the right side as deformation in the x-direction 
    type = FunctionPresetBC
    variable = disp_x
    boundary = 'right'
    function = velBC
  [../]
  [./anchor_y]
    #Anchors the left side against deformation in the y-direction
    type = PresetBC
    variable = disp_y 
    boundary = 'left right'
    value = 0.0 
  [../]
  [./anchor_z]
    #Anchors the left side against deformation in the z-direction
    type = PresetBC
    variable = disp_z 
    boundary = 'left right front back'
    value = 0.0 
  [../]
[]

[Materials]
  active = 'pfbulkmat elastic strain elasticity_tensor_concrete'
  [./pfbulkmat]
    type = PFFracBulkRateMaterial
    block = 1
    gc = 87 #1e-3
  [../]
  [./elastic]
    type = LinearIsoElasticPFDamage
    block = 1
    c = c
    kdamage = 1e-8
  [../]
  [./elasticity_tensor]
    type = ComputeElasticityTensor
    block = 1
    C_ijkl = '120.0 80.0'
    fill_method = symmetric_isotropic
  [../]
  [./strain]
    type = ComputeSmallStrain
    block = 1
    displacements = 'disp_x disp_y disp_z'
  [../]
  [./elasticity_tensor_concrete]
    #Creates the elasticity tensor using concrete parameters
    youngs_modulus = 16.5e9 #Pa
    poissons_ratio = 0.2
    type = ComputeIsotropicElasticityTensor
    block = 'vol'
  [../]
[]

[Postprocessors]
  [./resid_x]
    type = NodalSum
    variable = resid_x
    block = 1
#    boundary = 2
  [../]
  [./resid_y]
    type = NodalSum
    variable = resid_y
    block = 1
#    boundary = 2
  [../]
  [./resid_z]
    type = NodalSum
    variable = resid_z
    block = 1
#    boundary = 2
  [../]
[]

[Preconditioning]
  active = 'smp'
  [./smp]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type = Transient
    scheme = bdf2

  solve_type = PJFNK
  petsc_options_iname = '-pc_type -ksp_gmres_restart -sub_ksp_type -sub_pc_type -pc_asm_overlap'
  petsc_options_value = 'asm      31                  preonly       lu           1'
#  solve_type = NEWTON 
#  petsc_options_iname = '-pc_type -pc_hypre_type -ksp_gmres_restart'
#  petsc_options_value = 'hypre boomeramg 31'
  nl_abs_tol = 1e-6
  nl_rel_tol = 1e-6
  l_tol      = 1e-8
  l_max_its = 30
  nl_max_its = 20

  dt = 1e-3
  dtmin = 1e-10
  end_time = 0.4
#  num_steps = 100

  [./Predictor]
    type = AdamsPredictor #SimplePredictor
    scale = 1.0 
  [../]
[]

[Outputs]
  exodus = true
  csv = true
  gnuplot = false 
[]

[Debug]
    show_var_residual_norms = true
[]
