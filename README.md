# video-agent-skills

这个 fork 提供一组轻量短剧前期技能，用来补充本机已有的完整 AI 短剧、分镜、音频驱动和视频生成技能。

本 fork 的定位是：**显式调用、轻量输出、低路由冲突**。两个技能的 `allow_implicit_invocation` 都已关闭，安装后通常需要用 `$skill-name` 点名调用。

## 技能

| 技能 | 适合使用 | 主要输出 |
|---|---|---|
| `novel-to-shortdrama-script` | 已有中文小说/散文原文，只想轻量改编成短剧剧本 | 改编总纲、分集大纲、正式剧本、集末钩子 |
| `shortdrama-prompt-groups` | 已有短剧剧本/分集文本，只想拆成 4-15 秒 AI 视频平台提示词 | 自动资产清单、轻量分镜表、视频组提示词 |

## 与现有技能的边界

优先使用本机已有完整技能的场景：

- 完整 AI 短剧生产包、角色小传、资产锁定、CSV、平台输入包：用 `ai-short-drama`。
- GPT Image / Image2 故事板、角色/产品/场景参考图、视频模型提示词 QA：用 `ai-video-storyboard`。
- 即梦/Dreamina 音频驱动、`drive.wav`、beat map、lip sync、CLI 提交：用 `ai-comic-drama-audio-first` 或 `dreamina-cli`。
- HyperFrames/OpenVideo 成片渲染：用 `make-video` 或相关 HyperFrames 技能。

使用本 repo 的场景：

- 你明确想调用 `$novel-to-shortdrama-script` 做轻量剧本改编。
- 你明确想调用 `$shortdrama-prompt-groups` 把已有剧本拆成可复制到即梦、小云雀等平台的视频组提示词。

## 典型流程

```text
使用 $novel-to-shortdrama-script，把下面这段小说改编成 3 集短剧剧本，每集 1 分钟：
女主被继母逼着替妹妹嫁给传闻中毁容的总裁。婚礼当天，她发现总裁竟是三年前救过她的人。
```

然后继续：

```text
使用 $shortdrama-prompt-groups，根据下面这段剧本生成轻量分镜和可直接粘贴到视频平台的视频组提示词：
...
```

## `shortdrama-prompt-groups` 输出

`shortdrama-prompt-groups` 会输出：

- `自动提取资产清单`：角色、场景、道具，不生成资产 ID。
- `分镜表`：画面描述、场景、关联资产、时长、景别、运镜、角色动作、朝向、空间关系、情绪、台词、音效。
- `视频组列表`：4-15 秒一组的 AI 视频提示词，包含画面风格、场景、角色、道具、分段时间码、画面、运镜、声音和生成约束。

视频组格式示例：

```md
### 视频组1
画面风格和类型: 真人写实, 都市写实摄影，电影风格，自然光照，极致细节

场景: 客厅
角色：林小满、陈桂芳
道具：无

运镜+画面：[0-2.5s]
画面：...
运镜：...
声音：...

[2.5-5s]
画面：...
运镜：...
声音：... 台词（情绪）：角色："..."

其他需求：面部五官清晰稳定不变形，同一角色全程外貌一致，人体结构正常比例自然，动作连续自然不跳帧，无模糊无重影，无字幕无文字，无背景音乐。
```

## 安装

在本仓库目录下运行：

```bash
./install.sh
```

安装脚本会为 `skills/` 下的每个 skill 创建软链接。后续你在本仓库中修改 skill，各个智能体运行环境会通过软链接使用最新版本。默认安装位置：

- Codex: `~/.codex/skills/<skill-name>`
- Claude Code: `~/.claude/skills/<skill-name>`
- OpenClaw: `~/.openclaw/skills/<skill-name>`
- 共享智能体目录: `~/.agents/skills/<skill-name>`

安装脚本也会移除指向本 repo 旧路径的 `storyboard-lite` symlink，避免旧名称继续和现有分镜技能抢路由。

## 验证

安装后可以用下面的最小样例确认：

```text
使用 $shortdrama-prompt-groups，根据下面这段剧本生成轻量分镜和可直接粘贴到视频平台的视频组提示词：
女主推开办公室门，看见桌上的合同。老板说：“你终于来了。”
```

你应该看到：

- 默认故事类型和美术风格说明。
- `## 自动提取资产清单`。
- `## 分镜表`。
- `## 视频组列表`。
- 视频组里每组都有 `画面风格和类型`、`场景`、`角色`、`道具`、时间码、`画面`、`运镜`、`声音` 和 `其他需求`。

## 卸载

删除安装脚本创建的软链接：

```bash
rm ~/.codex/skills/novel-to-shortdrama-script
rm ~/.codex/skills/shortdrama-prompt-groups
rm ~/.claude/skills/novel-to-shortdrama-script
rm ~/.claude/skills/shortdrama-prompt-groups
rm ~/.openclaw/skills/novel-to-shortdrama-script
rm ~/.openclaw/skills/shortdrama-prompt-groups
rm ~/.agents/skills/novel-to-shortdrama-script
rm ~/.agents/skills/shortdrama-prompt-groups
```

## 上游

Forked from `towardsyoung/video-agent-skills`. This fork narrows routing and renames `storyboard-lite` to `shortdrama-prompt-groups` for safer coexistence with the user's existing Codex video skills.
