# UserObject J2 test
# apply uniform stretch in z direction to give
# trial stress_zz = 7, so sqrt(3*J2) = 7
# with zero Poisson''s ratio, this should return to
# stress_zz = 3, stress_xx = 2 = stress_yy
# (note that stress_zz - stress_xx = stress_zz - stress_yy = 1, so sqrt(3*j2) = 1,
#  and that the mean stress remains = 7/3)

[Mesh]
  type = GeneratedMesh
  dim = 3
  nx = 10
  ny = 1
  nz = 1
  xmin = -5
  xmax = 5
  ymin = -0.5
  ymax = 0.5
  zmin = -0.5
  zmax = 0.5
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

[Kernels]
  [./TensorMechanics]
      strain = FINITE
      displacements = 'disp_x disp_y disp_z'
      use_displaced_mesh = true
      add_variables = true
      save_in = 'reaction_x reaction_y reaction_z'
  [../]
[]


[BCs]
  [./x_left]
    type = FunctionPresetBC
    variable = disp_x
    boundary = 'left'
    function = '0.0'
  [../]
  [./x_right]
    type = FunctionPresetBC
    variable = disp_x
    boundary = 'right'
    function = '0.05*t'
  [../]
  [./y]
    type = FunctionPresetBC
    variable = disp_y
    boundary = 'top' # bottom
    function = '0'
  [../]
  [./z]
    type = FunctionPresetBC
    variable = disp_z
    boundary = 'front' # back
    function = '0'
  [../]
[]

[AuxVariables]
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
  [./f]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./iter]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./eqps]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./eqes]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./vm_stress]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./elastic_strain_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./elastic_strain_xy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./elastic_strain_xz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./elastic_strain_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./elastic_strain_yz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./elastic_strain_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./plastic_strain_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./plastic_strain_xy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./plastic_strain_xz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./plastic_strain_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./plastic_strain_yz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./plastic_strain_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./reaction_x]
    order = FIRST
    family = LAGRANGE
  [../]
  [./reaction_y]
    order = FIRST
    family = LAGRANGE
  [../]
  [./reaction_z]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[AuxKernels]
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
  [./f]
    type = MaterialStdVectorAux
    index = 0
    property = plastic_yield_function
    variable = f
  [../]
  [./iter]
    type = MaterialRealAux
    property = plastic_NR_iterations
    variable = iter
  [../]
  [./eqps]
    type = MaterialStdVectorAux
    index = 0
    property = plastic_internal_parameter   #this is same as eqps
    variable = eqps
  [../]
  [./plastic_strain_xx]
    type = MaterialRankTwoTensorAux
    property = plastic_strain
    variable = plastic_strain_xx
    i = 0
    j = 0
  [../]
  [./plastic_strain_xy]
    type = MaterialRankTwoTensorAux
    property = plastic_strain
    variable = plastic_strain_xy
    i = 0
    j = 1
  [../]
  [./plastic_strain_xz]
    type = MaterialRankTwoTensorAux
    property = plastic_strain
    variable = plastic_strain_xz
    i = 0
    j = 2
  [../]
  [./plastic_strain_yy]
    type = MaterialRankTwoTensorAux
    property = plastic_strain
    variable = plastic_strain_yy
    i = 1
    j = 1
  [../]
  [./plastic_strain_yz]
    type = MaterialRankTwoTensorAux
    property = plastic_strain
    variable = plastic_strain_yz
    i = 1
    j = 2
  [../]
  [./plastic_strain_zz]
    type = MaterialRankTwoTensorAux
    property = plastic_strain
    variable = plastic_strain_zz
    i = 2
    j = 2
  [../]
  [./elastic_strain_xx]
    type = MaterialRankTwoTensorAux
    property = elastic_strain
    variable = elastic_strain_xx
    i = 0
    j = 0
  [../]
  [./elastic_strain_xy]
    type = MaterialRankTwoTensorAux
    property = elastic_strain
    variable = elastic_strain_xy
    i = 0
    j = 1
  [../]
  [./elastic_strain_xz]
    type = MaterialRankTwoTensorAux
    property = elastic_strain
    variable = elastic_strain_xz
    i = 0
    j = 2
  [../]
  [./elastic_strain_yy]
    type = MaterialRankTwoTensorAux
    property = elastic_strain
    variable = elastic_strain_yy
    i = 1
    j = 1
  [../]
  [./elastic_strain_yz]
    type = MaterialRankTwoTensorAux
    property = elastic_strain
    variable = elastic_strain_yz
    i = 1
    j = 2
  [../]
  [./elastic_strain_zz]
    type = MaterialRankTwoTensorAux
    property = elastic_strain
    variable = elastic_strain_zz
    i = 2
    j = 2
  [../]
#  [./eqps]   #this is not necessary, since plastic_internal_parameter IS eqps
#    type = RankTwoScalarAux
#    scalar_type = EffectiveStrain
#    rank_two_tensor = plastic_strain
#    variable = eqps
#  [../]
  [./eqes]
    type = RankTwoScalarAux
    scalar_type = EffectiveStrain
    rank_two_tensor = elastic_strain
    variable = eqes
  [../]
  [./vm_stress]
    type = RankTwoScalarAux
    rank_two_tensor = stress
    scalar_type = VonMisesStress
    variable = vm_stress
  [../]
[]

[Postprocessors]
  [./s_xx]
    type = PointValue
    point = '0 0 0'
    variable = stress_xx
  [../]
  [./s_xy]
    type = PointValue
    point = '0 0 0'
    variable = stress_xy
  [../]
  [./s_xz]
    type = PointValue
    point = '0 0 0'
    variable = stress_xz
  [../]
  [./s_yy]
    type = PointValue
    point = '0 0 0'
    variable = stress_yy
  [../]
  [./s_yz]
    type = PointValue
    point = '0 0 0'
    variable = stress_yz
  [../]
  [./s_zz]
    type = PointValue
    point = '0 0 0'
    variable = stress_zz
  [../]
  [./f]
    type = PointValue
    point = '0 0 0'
    variable = f
  [../]
  [./iter]
    type = PointValue
    point = '0 0 0'
    variable = iter
  [../]
  [./eqps]
    type = PointValue
    point = '0 0 0'
    variable = eqps
  [../]
  [./eqes]
    type = PointValue
    point = '0 0 0'
    variable = eqes
  [../]
  [./e_xx]
    type = PointValue
    point = '0 0 0'
    variable = strain_xx
  [../]
  [./ee_xx]
    type = PointValue
    point = '0 0 0'
    variable = elastic_strain_xx
  [../]
  [./ep_xx]
    type = PointValue
    point = '0 0 0'
    variable = plastic_strain_xx
  [../]
  [./fd_force]
    type = NodalSum 
    boundary = 'right' 
    variable = reaction_x 
  [../]
  [./fd_disp]
    type = AverageNodalVariableValue
    boundary = 'right' 
    variable = disp_x 
  [../]
[]

[UserObjects]
  [./strength_constant]
    type = TensorMechanicsHardeningConstant
    value = 36.0E3    #yield strength
    #this appears to be different behavior than seen in https://groups.google.com/forum/?nomobile=true#!searchin/moose-users/TensorMechanicsHardeningConstant|sort:date/moose-users/33alD3Pe8l8/iSrjZ-JFDgAJ
  [../]
  [./strength_powerlaw]
    #This is the flow stress as a function of EQPS. Constant == perfectly plastic
    # params.addRequiredParam<Real>("value_0", "The yield strength when internal variable = 0");
    # params.addParam<Real>("epsilon0", 1.0, "The reference strain");
    # params.addParam<Real>("exponent", 0.0,  "Let p = internal_parameter.  Then value = value_0 * (p / epsilon0 + 1)^{exponent})");
    # params.addClassDescription("Hardening defined by power rule");
    # return _value_0 * std::pow(intnl / _epsilon0 + 1, _exponent);
    type = TensorMechanicsHardeningPowerRule
    value_0 = 36.0E3    #yield strength
    epsilon0 = 0.1
    exponent = 4
  [../]
  [./j2]
    type = TensorMechanicsPlasticJ2
    #yield_strength = strength_powerlaw
    yield_strength = strength_constant
    yield_function_tolerance = 1E-9
    internal_constraint_tolerance = 1E-9
  [../]
[]

[Materials]
  [./elasticity_tensor]
    # https://mooseframework.org/source/materials/ComputeElasticityTensor.html
    type = ComputeIsotropicElasticityTensor
    block = 0
    youngs_modulus = 29E6 #A36 steel
    poissons_ratio = 0.0 #0.27 
  [../]
  [./strain]
    type = ComputeFiniteStrain
    block = 0
    displacements = 'disp_x disp_y disp_z'
  [../]
  [./mc]
    type = ComputeMultiPlasticityStress
    block = 0
    ep_plastic_tolerance = 1E-9
    plastic_models = j2
    debug_fspb = crash
  [../]
[]


[Executioner]
  end_time = 1
  dt = 0.05
  type = Transient
[]


[Outputs]
  file_base = j2plasticity
  exodus = true
  [./csv]
    type = CSV
    [../]
[]
