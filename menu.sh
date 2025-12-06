#!/bin/sh
# RecipeTracker 演示菜单
# 提供两种模式：观看预录制演示 或 自己体验应用

while true; do
    clear
    echo ""
    echo "RecipeTracker 演示环境"
    echo "1.  观看演示"
    echo "2.  快速体验 (运行应用)"
    echo "3.  退出"
    echo ""
    printf "请选择 [1-3]: "
    read choice
    
    case $choice in
        1)
            clear
            echo "正在播放演示..."
            echo "提示: 按 q 可随时退出播放"
            echo ""
            sleep 1
            asciinema play /app/demo.cast
            echo ""
            echo "按回车键返回菜单..."
            read _
            ;;
        2)
            clear
            echo "启动 RecipeTracker 应用..."
            echo ""
            java -Djline.terminal=dumb -jar /app/app.jar
            echo ""
            echo "应用已退出，按回车键返回菜单..."
            read _
            ;;
        3)
            clear
            echo "感谢体验 RecipeTracker 再见！"
            exit 0
            ;;
        *)
            echo "无效选择，请输入 1-3..."
            sleep 1
            ;;
    esac
done
