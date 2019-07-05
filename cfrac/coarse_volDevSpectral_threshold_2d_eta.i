[Mesh]
  type = FileMesh
  file = mesh/nominal_mb2d_coarse.e 
  uniform_refine = 0
  boundary_id = '1 2 3 4 5 101 102 103 104' #Assign names to boundaries to make things clearer
  boundary_name = 'left right back left_internal right_internal left_load right_load left_vertical right_vertical'
  block_id = '1 2 3'
  block_name = 'main bLeft bRight'
[]

[GlobalParams]
  displacements = 'disp_x disp_y'
[]

[Modules]
  [./PhaseField]
    [./Nonconserved]
      [./c]
        free_energy = F
        kappa = kappa_op
        mobility = L
      [../]
    [../]
  [../]
  [./TensorMechanics]
    [./Master]
      [./mech]
        add_variables = true
        strain = SMALL
        save_in = 'resid_x resid_y'
        volumetric_locking_correction = true
      [../]
    [../]
  [../]
[]

[Variables]
  [./disp_x]
    block = 1
  [../]
  [./disp_y]
    block = 1
    scaling = 1
  [../]
  [./c]
    block = 1
    scaling = 1e1
  [../]
[]

[AuxVariables]
  [./resid_x]
    block = 1
  [../]
  [./resid_y]
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
  [./strain_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_xy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_xz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_yz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_zz]
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
    vals = '-1.666666666667e-6'     # 0.1mm/min
  [../]
[]

[Kernels]
  [./solid_x]
    type = PhaseFieldFractureMechanicsOffDiag
    variable = disp_x
    component = 0
    c = c
  [../]
  [./solid_y]
    type = PhaseFieldFractureMechanicsOffDiag
    variable = disp_y
    component = 1
    c = c
  [../]
  [./dcdt]
    type = TimeDerivative
    variable = c
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
  [./strain_xx]
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_xx
    index_i = 0
    index_j = 0
  [../]
  [./strain_xy]
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_xy
    index_i = 0
    index_j = 1
  [../]
  [./strain_xz]
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_xz
    index_i = 0
    index_j = 2
  [../]
  [./strain_yy]
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_yy
    index_i = 1
    index_j = 1
  [../]
  [./strain_yz]
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_yz
    index_i = 1
    index_j = 2
  [../]
  [./strain_zz]
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_zz
    index_i = 2
    index_j = 2
  [../]
[]

[BCs]
  [./anchor_x]
    #Anchors the left side against deformation in the x-direction 
    type = PresetBC
    variable = disp_x 
    boundary = 'left_load'
    value = 0.0 
  [../]
  [./right_x]
    #Moves the right side as deformation in the x-direction 
    type = FunctionPresetBC
    variable = disp_x
    boundary = 'right_load'
    function = velBC
  [../]
  [./anchor_y]
    #Anchors the left side against deformation in the y-direction
    type = PresetBC
    variable = disp_y 
    boundary = 'left_vertical right_vertical'
    value = 0.0 
  [../]
[]

[Materials]
  [./pfbulkmat]
    type = GenericConstantMaterial
    prop_names = 'gc_prop l visco'
    prop_values = '500 0.0001666666667 1e-8'
    block = 'main'
  [../]
  [./pfbulkmat_inert]
    type = GenericConstantMaterial
    prop_names = 'gc_prop l visco'
    prop_values = '1e6 0.0001666666667 1e-8'
    block = 'bLeft bRight'
  [../]
  [./define_mobility]
    type = ParsedMaterial
    material_property_names = 'gc_prop visco'
    f_name = L
    function = '1.0/(gc_prop * visco)'
  [../]
  [./define_kappa]
    #Kappa/2 = gradient term coefficient
    type = ParsedMaterial
    material_property_names = 'gc_prop l'
    f_name = kappa_op
    function = 'gc_prop * l * 3.0/8.0 * 2.0'
  [../]
  [./elasticity_tensor_concrete]
    #Creates the elasticity tensor using concrete parameters
    youngs_modulus = 3.5e9 #Pa
    poissons_ratio = 0.32
    type = ComputeIsotropicElasticityTensor
    block = 'main bLeft bRight'
  [../]
  [./damage_stress]
    type = ComputeLinearElasticPFFractureStress
    c = c
    E_name = 'elastic_energy'
    D_name = 'degradation'
    F_name = 'local_fracture_energy'
    barrier_energy = 'barrier'
    decomposition_type = strain_vol_dev_spectral
  [../]
  [./degradation]
    type = DerivativeParsedMaterial
    f_name = degradation
    args = 'c'
    function = '(1.0-c)^2*(1.0 - eta) + eta'
    constant_names       = 'eta'
    constant_expressions = '1.0e-4'
    derivative_order = 2
  [../]
  [./local_fracture_energy]
    type = DerivativeParsedMaterial
    f_name = local_fracture_energy
    args = 'c'
    material_property_names = 'gc_prop l'
    function = 'c * gc_prop / l * 3.0/8.0'
    derivative_order = 2
  [../]
  [./fracture_driving_energy]
    type = DerivativeSumMaterial
    args = c
    sum_materials = 'elastic_energy local_fracture_energy'
    derivative_order = 2
    f_name = F
  [../]
  [./barrier_energy]
    type = ParsedMaterial
    f_name = barrier
    material_property_names = 'gc_prop l'
    function = '3 * gc_prop / 16 / l'
  [../]
[]

[Postprocessors]
  [./resid_x]
    type = NodalSum
    variable = resid_x
    boundary = 'right'
  [../]
  [./resid_x_internal]
    type = NodalSum
    variable = resid_x
    boundary = 'right_internal'
  [../]
  [./stressInt_xx]
    type = InterfaceIntegralVariableValuePostprocessor
    variable = stress_xx
    boundary = 'right_internal'
  [../]
  [./stressAvg_xx]
    type = InterfaceAverageVariableValuePostprocessor 
    variable = stress_xx
    boundary = 'right_internal'
  [../]
  [./resid_y]
    type = NodalSum
    variable = resid_y
    boundary = 'right'
  [../]
  [./fd_disp]
    type = SideAverageValue
    variable = disp_x
    boundary = 'right'
  [../]
[]

[Preconditioning]
  active = 'smp'
  [./smp]
    type = SMP
    full = true
#    solve_type = NEWTON
  [../]
[]

[Executioner]
  type = Transient
    scheme = bdf2

  solve_type = PJFNK
  petsc_options = '-snes_converged_reason -ksp_converged_reason'
  #PETSC1: Settings from Mark Messner: https://groups.google.com/forum/?nomobile=true#!searchin/moose-users/predictor%7Csort:date/moose-users/VQukwKv0Kt0/foKCakujCAAJ
  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'lu superlu_dist'

  nl_abs_tol = 1e-6
  nl_rel_tol = 1e-6
  l_tol      = 1e-8
  l_max_its = 20
  nl_max_its = 30

  dt = 10.0
  dtmin = 1e-10
  end_time = 900.0

  [./Predictor]
    type = AdamsPredictor
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
