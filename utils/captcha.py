import random
from PIL import Image, ImageDraw

def random_rgb():
    return random.randint(0, 255), random.randint(0, 255), random.randint(0, 255)

def generate_captcha(width=120, height=40, length=4):
    # 生成随机字符串
    chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789'
    captcha_text = "".join(random.choice(chars) for _ in range(length))

    # 创建图片对象
    image = Image.new("RGB", (width, height), "white")
    draw = ImageDraw.Draw(image)

    # 绘制验证码
    x = 10
    for i, char in enumerate(captcha_text):
        y = random.randint(5, 10)
        draw.text((x, y), char, fill=random_rgb())
        x += width // (length + 1)

    # 添加干扰元素（点、线）
    for _ in range(20):
        x1, y1 = random.randint(0, width), random.randint(0, height)
        draw.point((x1, y1), fill=random_rgb())
    for _ in range(3):
        x1, y1 = random.randint(0, width), random.randint(0, height)
        x2, y2 = random.randint(0, width), random.randint(0, height)
        draw.line((x1, y1, x2, y2), fill=random_rgb(), width=2)

    return image, captcha_text
