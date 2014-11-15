exports             = exports ? @
exports.DefaultFile = "FlappySwift.spritebuilder/Source/GameplayScene.swift"

exports.Tutorial = () ->
  step "Welcome"
  step "Adding the Character"
  step "Start to Fly!"
  step "Moving to the Right!"
  step "Adding Obstacles"
  step "Finishing Up"

exports.Preprocess = (files) ->
  path        = "FlappySwift.spritebuilder/Source/GameplayScene.swift"
  files[path] = files[path].replace /func([\s\S]+?{)/igm, "override func$1"
