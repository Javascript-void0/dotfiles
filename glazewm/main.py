from subprocess import run
from re import search
from time import sleep

BLOCK_FULL = '█'
BLOCK_PART = '▒'

class BatteryBarComponent():

    blink_state = True

    def get(self, path: str, get: str) -> int:
        output = run(f'wmic Path {path} Get {get}', capture_output=True, text=True, shell=True).stdout
        # regex to filter out numbers
        return int(search(r'\d+', output).group(0))

    def write_to_file(self, bar: str) -> None:
        f = open('battery.txt', 'w', encoding='utf-16')
        f.writelines([bar])
        f.close()

    def create_bar(self, battery: int, charging: bool) -> str:
        bar = ''
        num_full = battery // 20 # ranges from [0,5]
        bar = BLOCK_FULL * num_full

        if battery == 100:
            if not charging:
                if self.blink_state:
                    return f'{BLOCK_FULL*4}{BLOCK_PART}'
                return bar
                    
        elif not charging:
            if self.blink_state:
                bar += BLOCK_PART
            else:
                bar += BLOCK_FULL

        # charging but not at 100%
        elif self.blink_state:
            bar += BLOCK_PART

        bar = bar.ljust(5)
        return bar

    def start(self):
        while True:
            battery = self.get('Win32_Battery', 'EstimatedChargeRemaining')
            state = self.get('Win32_Battery', 'BatteryStatus')
    
            self.blink_state = not self.blink_state
            bar = self.create_bar(battery, state != 1)
            self.write_to_file(bar)
            sleep(1)



def main():
    component = BatteryBarComponent()
    component.start()

if __name__ == "__main__":
    main()
