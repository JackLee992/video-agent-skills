---
name: shortdrama-prompt-groups
description: Convert an already-written short-drama script, selected episode, or confirmed shot list into lightweight asset notes, a compact storyboard table, and 4-15 second paste-ready AI video prompt groups. Use only when explicitly invoked or when the user specifically asks for platform-ready short-drama video prompt groups from existing script text. Do not use for broad video creation, novel adaptation, full AI short-drama production packages, asset-locking workflows, storyboard-image prompt packs, audio-first Dreamina execution, or HyperFrames rendering.
---

# Short-Drama Prompt Groups

Use this skill to turn existing script text into a practical storyboard table and paste-ready video prompt groups with minimal user input. This skill is intentionally narrow and standalone. It does not replace a full production package, asset bible, audio-first workflow, model submission workflow, or rendered video workflow.

## Routing Guard

Use this skill when all of these are true:

- The user already has a script, selected episode, scene text, or confirmed shot list.
- The desired output is a lightweight storyboard plus `## 视频组列表`.
- The video groups should be 4-15 second prompt blocks that can be pasted into AI video platforms such as 即梦 or 小云雀.

Do not use this skill when:

- The input is only a novel/prose source and the user needs an adapted short-drama script first.
- The user wants a full AI short-drama production package with character bios, asset IDs, locked references, CSV deliverables, platform handoff files, or validation.
- The user wants storyboard-image prompt packs, character/product/environment reference prompts, or model-specific image/video generation strategy.
- The user wants audio-first Dreamina execution, `drive.wav`, beat maps, lip sync, or CLI submission.
- The user wants a finished HyperFrames/OpenVideo rendered composition.

If the user asks for one of those broader workflows, route to the appropriate existing specialized skill instead of continuing here.

## Inputs

Required:

- Already-written script text, selected episode text, scene text, or a confirmed shot list.

Optional:

- Story type.
- Art style.
- Output format.
- Whether to include or omit the extracted asset list.
- Whether to include or omit video prompt groups.

Defaults:

- Story type: 都市职场
- Art style: 真人现代都市
- Output format: Markdown
- Asset mode: extract asset names automatically; do not generate asset IDs.
- Video group mode: include video prompt groups after the storyboard table.

If the user only provides a script, proceed with defaults and briefly state the assumed story type and art style before the output. If the user asks what options are available, show the concise option lists in "Option Prompt".

## Story Type Options

Use these as suggested options, not hard limits. Accept custom user-provided story types.

- 都市职场
- 甜宠恋爱
- 悬疑惊悚
- 热血动作
- 仙侠玄幻
- 家庭温情
- 喜剧幽默
- 科幻末世
- 历史史诗
- 心理剧情
- 恐怖超自然
- 成长剧情

## Art Style Options

Use these as suggested options, not hard limits. Accept custom user-provided art styles.

- 真人现代都市
- 真人古装中国
- 真人武侠
- 2D 国风
- 2D 日漫
- 2D 扁平设计
- 2D 成熟都市恋爱
- 3D 动画
- 3D 国风
- 3D 国风赛博
- 3D 黏土定格

## Asset Extraction

Before the storyboard table, extract assets from the script unless the user asks to omit the asset list.

Extract:

- 角色: named characters and clear role aliases such as 男主, 女主, 母亲, 老板.
- 场景: explicit locations and repeated implied locations such as 办公室, 客厅, 医院走廊.
- 道具: plot-relevant objects such as 手机, 合同, 钥匙, 药瓶.

Rules:

- Do not invent asset IDs.
- Use only names that are explicit in the script or conservative neutral labels.
- If a character's name is unknown, use stable neutral labels such as 女主, 男主, 母亲.
- If the user later supplies real assets, align names to those assets but still omit IDs unless requested.
- Asset extraction output must use exactly these columns: `名称`, `类型`, `描述词`, `出镜位置`.
- `类型` must be one of: `角色`, `场景`, `道具`.
- `描述词` should be concise visual or narrative descriptors extracted from the script, separated with `、`, such as `年轻女性、焦虑、职业装` or `办公室、现代、会议桌`.
- `出镜位置` should identify where the asset appears in the script or storyboard, such as `第1场`, `第2-3镜`, `开场`, or a short quoted script cue. Use the most specific reliable position available.

## Output Format

Default output:

```md
假设：故事类型为「都市职场」，美术风格为「真人现代都市」。

## 自动提取资产清单

| 名称 | 类型 | 描述词 | 出镜位置 |
|---|---|---|---|

## 分镜表

| 序号 | 画面描述 | 场景 | 关联资产名称 | 时长 | 景别 | 运镜 | 角色动作 | 朝向 | 空间关系 | 情绪 | 台词 | 音效 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|

## 视频组列表

### 视频组1
画面风格和类型: 真人写实, 都市写实摄影，电影风格，自然光照，极致细节

场景: 客厅
角色：角色A、角色B
道具：手机、合同

运镜+画面：[0-3s]
画面：...
运镜：...
声音：...

[3-7s]
画面：...
运镜：...
声音：... 台词（情绪）：角色A："..."

其他需求：面部五官清晰稳定不变形，同一角色全程外貌一致，人体结构正常比例自然，动作连续自然不跳帧，无模糊无重影，无字幕无文字，无背景音乐。
```

If the user requests CSV, XML, or JSON, keep the same storyboard fields and omit asset IDs. Still include the video prompt groups in Markdown unless the user explicitly asks for a fully machine-readable output.

## Storyboard Rules

- Follow the script order exactly.
- Do not add plot events that are not in the script.
- Do not omit dialogue.
- Copy dialogue verbatim into the `台词` field.
- Every shot needs a scene.
- Visible characters and plot-relevant props must appear in `关联资产名称`.
- `角色动作` should start with `(开篇)` or `(承接上镜:...)`.
- Maintain visual continuity for facing direction and spatial relation within the same scene.
- Use `朝向` for character facing; use `—` for empty shots or pure object closeups.
- Use `空间关系` for multi-character shots; use `—` for single-character, empty, or object shots.
- Dialogue shot duration must be long enough for the line. Use roughly 4 chars/sec for anger, 3 chars/sec for normal speech, 2 chars/sec for sadness, whispering, or weakness, then add about 1 second.
- Non-dialogue shots should usually be 6 seconds or shorter.
- `音效` may include only concrete physical sound sources, environment sound, action sound, or foley. Do not write BGM, 配乐, 旋律, or instruments as mood scoring.
- Avoid unnecessary decorative shots. Merge adjacent shots if they repeat the same information.

## Video Group Rules

After the storyboard table, output `## 视频组列表`. Video groups are generation-ready prompt blocks derived from the storyboard. They should be usable directly in platforms such as 即梦 or 小云雀.

Do not output API response JSON, scene IDs, episode IDs, image URLs, video URLs, status fields, or timestamps unless the user explicitly asks for an API mock. If the user provides an API response as reference, use only the prompt-writing style and duration discipline from it.

Grouping:

- Build video groups from the storyboard in order. Do not add plot events beyond the script or storyboard.
- Each video group duration must be 4-15 seconds.
- Prefer grouping continuous shots in the same scene and dramatic beat into one video group.
- If a single storyboard shot would exceed 15 seconds, split it into smaller timed beats while preserving the original dialogue order.
- Do not create groups shorter than 4 seconds. Merge or rebalance adjacent beats unless the user explicitly requests a shorter fragment.
- Restart each video group's internal timecode at `[0s]`.
- Use precise internal time ranges such as `[0-2.5s]`, `[2.5-5s]`, `[5-8s]`. The final timecode must match the group duration.
- Keep scene, character, prop, wound, costume, emotional, and spatial continuity across groups. Use phrases such as `承接上组状态`, `延续本场左右基线`, or `尾帧承接下组` where useful.

Format every video group exactly like this:

```md
### 视频组1
画面风格和类型: 真人写实, 都市写实摄影，电影风格，自然光照，极致细节

场景: 场景名称
角色：角色A、角色B
道具：道具A、道具B

运镜+画面：[0-2.5s]
画面：...
运镜：...
声音：...

[2.5-5s]
画面：...
运镜：...
声音：... 台词（情绪）：角色A："原文台词"

其他需求：面部五官清晰稳定不变形，同一角色全程外貌一致，人体结构正常比例自然，动作连续自然不跳帧，无模糊无重影，无字幕无文字，无背景音乐。
```

Header rules:

- `画面风格和类型` should combine the requested art style with practical image-generation descriptors. For modern live-action short drama, use `真人写实, 都市写实摄影，电影风格，自然光照，极致细节` unless the user requested another style.
- `场景` must be a concise location name from the storyboard.
- `角色` must list only visible or audibly speaking characters in the group.
- `道具` must list plot-relevant visible props. Use `无` only when no important prop appears.

Prompt writing rules:

- Each timed beat must include `画面：`, `运镜：`, and `声音：`.
- `画面` must describe visible action, composition, facing direction, screen position, emotional micro-expression, body movement, and continuity state. Prefer concrete filmable details over abstract summaries.
- For multi-character scenes, establish or preserve a left/right baseline, for example `本场左右基线：林小满画面中央偏右，厨房门在画面左侧深处，沙发在画面右侧`.
- Use generation-friendly camera language: `中景`, `近景`, `偏紧近景`, `极近特写`, `远景`, `微距特写`, `Dolly In`, `Dolly Out`, `Truck`, `Orbit`, `Rack Focus`, `Tilt Up`, `Crash Zoom`, `手持微晃`, `固定`, `深焦`, `浅焦`, `长焦压缩空间`.
- Describe lighting and atmosphere inside the visual beat when it affects the image: `暖黄侧光`, `冷白日光灯`, `窗帘缝隙透入的下午阳光`, `手机蓝光`, `台灯光圈`, `浮尘`, `汗珠`, `碎纸片飘落`.
- `声音` must include only diegetic sound, foley, environmental sound, and dialogue. Do not include background music or mood scoring.
- Dialogue must be copied verbatim and formatted as `台词（情绪）：角色："台词"` or `台词（续，情绪）：角色："台词"`.
- When a beat is mainly the listener's reaction, keep the speaking line in `声音` if it continues from the previous speaker, and describe the listener's micro-reaction in `画面`.
- Use `尾帧` notes for continuity when the final pose, gaze, or action should carry into the next group.
- End every group with the exact `其他需求` line from the template unless the user requested a different technical constraint.

Quality checklist before final output:

- The storyboard table still exists and remains readable.
- Every script dialogue line appears in the storyboard and in the relevant video group.
- Every video group is 4-15 seconds.
- Every video group has style, scene, roles, props, timed beats, camera movement, sound, and the final technical constraints.
- Video prompts contain enough continuity detail for character consistency, spatial consistency, action continuity, and paste-ready video generation.

## Option Prompt

When the user asks for choices, show concise choices:

```text
故事类型可选：都市职场、甜宠恋爱、悬疑惊悚、热血动作、仙侠玄幻、家庭温情、喜剧幽默、科幻末世、历史史诗、心理剧情、恐怖超自然、成长剧情。也可以直接写其他类型。

美术风格可选：真人现代都市、真人古装中国、真人武侠、2D 国风、2D 日漫、2D 扁平设计、2D 成熟都市恋爱、3D 动画、3D 国风、3D 国风赛博、3D 黏土定格。也可以直接写其他风格。
```
