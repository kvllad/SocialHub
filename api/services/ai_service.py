"""
AI Service for generating personalized tasks using DeepSeek API
"""
import json
import asyncio
import os
from typing import Optional
from datetime import date
from openai import OpenAI


class AIService:
    """Service for AI-powered task generation using DeepSeek"""

    API_KEY = os.getenv("API_KEY")
    BASE_URL = os.getenv("BASE_URL")
    MODEL = os.getenv("deepseek-chat")

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
        user_department: str = ""
    ) -> Optional[dict]:
        """
        Generate a personalized task using DeepSeek API

        Returns:
            dict with 'name' and 'coin_reward' (0-50 coins)
        """
        interests_str = ", ".join(user_interests) if user_interests else "общие интересы"

        prompt = f"""Представь, что ты наставник сотрудника Сбера. Тебе нужно придумать для него индивидуальное задание, которое будет соответствовать его опыту, возрасту и интересам.

Информация о сотруднике ниже:
* **Возраст:** {user_age}
* **Интересы (массив строк):** {interests_str}
* **Должность:** {user_position}

Сформируй ровно одно задание, которое он мог бы сделать только в офисе. Задание должно иметь структуру:

[
  {{
    "название": "string",
    "количество_баллов": number (0-50)
  }}
]

**Требования:**
* Баллы — целое число от 0 до 50.
* Название должно соответствовать навыкам и интересам сотрудника.
* Задание должно быть выполнимым только в офисе оффлайн
* Не используй лишний текст, выводи только итоговый объект.
* Задание должно быть легким и выполнимым за 2 минуты
* Задание должно быть не сильно связано с работой, но обязатнльно чтобы его нужно было выполнять в офисе"""

        try:
            # Run synchronous OpenAI client in thread pool
            def _call_api():
                client = OpenAI(
                    api_key=AIService.API_KEY,
                    base_url=AIService.BASE_URL
                )

                response = client.chat.completions.create(
                    model=AIService.MODEL,
                    messages=[
                        {"role": "system",
                         "content": "Ты наставник сотрудника Сбера, который генерирует персональные задания для офиса."},
                        {"role": "user", "content": prompt}
                    ],
                    temperature=1.5,
                    max_tokens=150
                )

                return response.choices[0].message.content

            # Execute in thread pool to avoid blocking
            loop = asyncio.get_event_loop()
            content = await loop.run_in_executor(None, _call_api)

            if not content:
                print("DeepSeek API returned empty content")
                return None

            content = content.strip()

            # Remove markdown code blocks if present
            if content.startswith("```"):
                lines = content.split("\n")
                content = "\n".join(lines[1:-1])
                if content.startswith("json"):
                    content = content[4:].strip()

            # Parse JSON array
            task_list = json.loads(content)

            # Extract first task from array
            if isinstance(task_list, list) and len(task_list) > 0:
                task_data = task_list[0]
            else:
                task_data = task_list

            # Validate the response structure
            if "название" not in task_data or "количество_баллов" not in task_data:
                print(f"Invalid task data structure: {task_data}")
                return None

            # Ensure coin_reward is within bounds
            coin_reward = int(task_data["количество_баллов"])
            if coin_reward < 0:
                coin_reward = 0
            elif coin_reward > 50:
                coin_reward = 50

            return {
                "name": str(task_data["название"]),
                "coin_reward": coin_reward
            }

        except Exception as e:
            print(f"Error generating personalized task: {e}")
            import traceback
            traceback.print_exc()
            return None
