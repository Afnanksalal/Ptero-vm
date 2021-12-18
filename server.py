import os
import aiohttp      
import asyncio  
os.system("pip install aiofiles")
import aiofiles


async def t():
    async with aiohttp.ClientSession() as session:
        async with session.get("https://raw.githubusercontent.com/afnan007a/Ptero-vm/main/installer.sh") as resp:
            if resp.status == 200:
                f = await aiofiles.open('./installer.sh', mode='wb')
                await f.write(await resp.read())
                await f.close()

def main():
    loop = asyncio.get_event_loop()
    loop.run_until_complete(t())
    loop.close()
    os.system("bash installer.sh")

if __name__ == '__main__':
    main()
