# pwsh-intervalTimer

This project is inspired by [rlue's timer](https://github.com/rlue/timer) project.

_Requirement: PowerShell on Windows_

**pwsh-intervalTimer** is a command line interval timer written in `PowerShell` syntax.

## Features

* Customizable countdown timer with customizable intervals.
* Calming, serene alert tones inspired by Buddhist meditation bells.
* Customizable timer delays and repetitions.

## Preview

![Preview](https://drive.google.com/uc?id=1ofldY5RFdYPQq8KmutsSW8TGoWZVlRdp)

## Installation

Via `PowerShell Gallery` with the following command:
   
   ```pwsh
   Install-Module interval-timer
   ```

## Usage

```
$ timer [duration(in minutes), duration2, .. durationN] [options] [value]

    -r rounds                        Repeat timer (n < 0 repeats forever)
    -d seconds                       Delay timer start
```

Timer duration may be specified in decimal form, for example, 90 seconds may be specified as `1.5`.
If multiple durations are specified, an alert will be triggered at the end of each interval.

For more information, run:

```pwsh
man timer
```

### Examples

#### Simple timer (30m)

    $ timer 30

#### Meditation timer

> Let’s say you meditate for 30 minutes. You can set the interval bell to ring
> after 5 minutes, so you can spend the first 5 minutes settling/relaxing
> yourself and your mind, and then begin the actual meditation practice when
> the interval bell rings.  

    $ timer 5,25

#### [Pomodoro Technique](https://todoist.com/productivity-methods/pomodoro-technique)

> 1. Decide on the task to be done.
> 2. Set the pomodoro timer (traditionally to 25 minutes).
> 3. Work on the task until the timer rings.
> 4. After the timer rings, put a checkmark on a piece of paper.
> 5. If you have fewer than four checkmarks, take a short break (3–5 minutes), then go to step 2.
> 6. After four pomodoros, take a longer break (15–30 minutes), reset your checkmark count to zero, then go to step 1.

    $ timer 25,5,25,5,25,5,25,20

Or to repeat this 135-minute set twice in a row,

    $ timer 25,5,25,5,25,5,25,20 -r 2
    
## Credits

<table>
  <tr>
    <td align="center"><a href="https://www.linkedin.com/in/rajeswarkhan/" target="_blank"><img src="https://media-exp1.licdn.com/dms/image/C4D03AQHgpVP7ohT_ZQ/profile-displayphoto-shrink_800_800/0/1516901471017?e=1665619200&v=beta&t=FcscyswT5V0YnGczJPCU-t_TfmylFeFyvhM8eVUKf78" width="100px;" alt=""/><br /><sub><b>Rajeswar Khan</b></sub></a><br /></td>
  </tr>
</table>
