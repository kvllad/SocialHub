"""
AI Service for generating personalized tasks using DeepSeek API
"""
import httpx
from typing import Optional
from datetime import datetime, date


class AIService:
    """Service for AI-powered task generation using DeepSeek"""

    API_KEY = "sk-0e56b8b0c41b4f2686402185972da809"
    BASE_URL = "https://api.deepseek.com"
    MODEL = "deepseek-chat"

    @staticmethod
    def calculate_age(date_of_birth: date) -> int:
        """Calculate age from date of birth"""
        today = date.today()
        return today.year - date_of_birth.year - ((today.month, today.day) < (date_of_birth.month, date_of_birth.day))

    @staticmethod
    async def generate_personalized_task(
        user_age: int,
        user_interests: list[str],
        user_position: str,
        user_department: str
    ) -> Optional[dict]:
        """
        Generate a personalized task using DeepSeek API

        Returns:
            dict with 'name' and 'coin_reward' (0-50 coins)
        """
        interests_str = ", ".join(user_interests) if user_interests else "общие интересы"

        prompt = f"""Ты — ИИ-агент для создания персонализированных заданий для сотрудников компании.

Твоя задача — сгенерировать одно короткое, простое задание, которое сотрудник может выполнить в офисе за пару минут.

Информация о сотруднике:
- Возраст: {user_age} лет
- Интересы: {interests_str}
- Должность: {user_position}
- Отдел: {user_department}

Требования к заданию:
1. Задание должно быть выполнено ТОЛЬКО В ОФИСЕ
2. Задание должно быть простым и занимать не более 2 минут
3. Задание должно учитывать интересы и должность сотрудника
4. Награда: от 0 до 50 коинов (зависит от сложности)
5. Задание должно быть конкретным и понятным

Примеры хороших заданий:
- "Поделись рецептом любимого блюда с коллегой" (10 коинов)
- "Предложи идею для улучшения рабочего пространства" (20 коинов)
- "Помоги коллеге с технической проблемой" (25 коинов)
- "Организуй мини-опрос в своём отделе на интересную тему" (15 коинов)

Верни ответ СТРОГО в формате JSON:
{{"name": "текст задания", "coin_reward": число_от_0_до_50}}

Только JSON, без дополнительного текста!"""

        try:
            async with httpx.AsyncClient() as client:
                response = await client.post(
                    f"{AIService.BASE_URL}/chat/completions",
                    headers={
                        "Authorization": f"Bearer {AIService.API_KEY}",
                        "Content-Type": "application/json"
                    },
                    json={
                        "model": AIService.MODEL,
                        "messages": [
                            {"role": "user", "content": prompt}
                        ],
                        "temperature": 0.8,
                        "max_tokens": 150
                    },
                    timeout=30.0
                )

                if response.status_code != 200:
                    print(f"DeepSeek API error: {response.status_code} - {response.text}")
                    return None

                result = response.json()

                # Extract the generated content
                content = result["choices"][0]["message"]["content"].strip()

                # Parse JSON from the response
                import json
                # Remove markdown code blocks if present
                if content.startswith("```"):
                    content = content.split("```")[1]
                    if content.startswith("json"):
                        content = content[4:].strip()

                task_data = json.loads(content)

                # Validate the response
                if "name" not in task_data or "coin_reward" not in task_data:
                    print(f"Invalid task data structure: {task_data}")
                    return None

                # Ensure coin_reward is within bounds
                coin_reward = int(task_data["coin_reward"])
                if coin_reward < 0:
                    coin_reward = 0
                elif coin_reward > 50:
                    coin_reward = 50

                return {
                    "name": str(task_data["name"]),
                    "coin_reward": coin_reward
                }

        except Exception as e:
            print(f"Error generating personalized task: {e}")
            return None
