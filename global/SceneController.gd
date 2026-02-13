extends Node

var farctions: Array[FarctionInfo]
var playerController:PlayerController = null
var gameController:GameController = null
var buildcontroller: BuildController = null
func load_game_scene_async(game_scene_path: String, input_farctions: Array[FarctionInfo]):
	farctions = input_farctions
		# 2. 循环检查加载状态并更新进度
	var load_error = ResourceLoader.load_threaded_request(game_scene_path)
	if load_error != OK:
		print("加载失败：", load_error)
		$StartButton.disabled = false
		$LoadingPanel.visible = false
		return

	# 2. 循环检查加载状态并更新进度
	var load_status = ResourceLoader.THREAD_LOAD_IN_PROGRESS
	while load_status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		# 获取当前加载进度（0.0 到 1.0）
		#var progress = ResourceLoader.load_threaded_get_progress(game_scene_path)
		# 等待下一帧再检查（避免卡死主线程）
		#await process_frame
		# 更新加载状态
		load_status = ResourceLoader.load_threaded_get_status(game_scene_path)

	# 3. 加载完成后处理结果
	match load_status:
		ResourceLoader.THREAD_LOAD_LOADED:
			# 获取加载完成的场景并切换
			print("加载成功")
			var game_scene = ResourceLoader.load_threaded_get(game_scene_path)
			await get_tree().change_scene_to_packed(game_scene)
			get_tree().connect("tree_changed",_on_tree_changed)
			print("123456",get_tree().current_scene) # 输出新场景。
		ResourceLoader.THREAD_LOAD_FAILED:
			# 加载失败处理
			$LoadingPanel/LoadingLabel.text = "加载失败！请重试"
			$StartButton.disabled = false
			# 3秒后隐藏加载面板
			await get_tree().create_timer(3.0).timeout
			$LoadingPanel.visible = false
func _on_tree_changed():
	# 获取当前场景
	var current = get_tree().current_scene
	if current:
		print("当前场景：", current.name)
		# 断开信号，避免重复触发
		get_tree().disconnect("tree_changed", _on_tree_changed)
		var gameController = current.get_child(7)
		if gameController != null:
			gameController.setFarctionInfos(farctions)
			gameController.startGame()
		else:
			print("gamecontroller is null")

func setBuildController(controller: BuildController):
	buildcontroller = controller
	
func getBuildController() -> BuildController:
	return buildcontroller
	
