#!/usr/bin/env python3

import datetime
import uuid


def create_isc_content(event_dict):
    ics_content = "BEGIN:VCALENDAR\n"\
        "VERSION:2.0\n"\
        "PRODID:s1ro6-Calendar\n"\
        "CALSCALE:GREGORIAN\n"\
        "X-WR-CALNAME:中国法定节假日\n"\
        "X-APPLE-LANGUAGE:zh\n"\
        "X-APPLE-REGION:CN\n"

    for year, holiday_list in event_dict.items():
        for holiday in holiday_list:
            stamp = datetime.datetime.today().strftime("%Y%m%dT%H%M%SZ")
            ics_content += "\nBEGIN:VEVENT\n"
            ics_content += f"UID:{str(uuid.uuid4())}\n"
            ics_content += "TRANSP:OPAQUE\n"
            ics_content += f"SUMMARY:{holiday[0]}\n"
            ics_content += f"DTSTART;VALUE=DATE:{year + holiday[1]}\n"
            ics_content += f"DTEND;VALUE=DATE:{year + holiday[2]}\n"
            ics_content += f"DTSTAMP:{stamp}\n"
            ics_content += "SEQUENCE:0\n"
            ics_content += "BEGIN:VALARM\n"
            ics_content += f"X-WR-ALARMUID:{str(uuid.uuid4())}\n"
            ics_content += f"UID:{str(uuid.uuid4())}\n"
            ics_content += "TRIGGER:-PT15H\n"
            ics_content += "X-APPLE-DEFAULT-ALARM:TRUE\n"
            ics_content += "ATTACH;VALUE=URI:Basso\n"
            ics_content += "ACTION:AUDIO\n"
            ics_content += "END:VALARM\n"
            ics_content += "END:VEVENT\n"
    return ics_content + "END:VCALENDAR\n"


if __name__ == "__main__":
    event_list = {
        "2021": [
            ["元旦假期", "0101", "0104"],
            ["春节假期", "0211", "0218"],
            ["春节补休上班", "0207", "0208"],
            ["春节补休上班", "0220", "0221"],
            ["清明节假期", "0403", "0406"],
            ["劳动节假期", "0501", "0506"],
            ["劳动节补休上班", "0425", "0426"],
            ["劳动节补休上班", "0508", "0509"],
            ["端午节假期", "0612", "0615"],
            ["中秋节假期", "0919", "0922"],
            ["中秋节补休上班", "0918", "0919"],
            ["国庆日假期", "1001", "1008"],
            ["国庆补休上班", "0926", "0927"],
            ["国庆补休上班", "1009", "1010"],
        ],
        "2022": [
            ["元旦假期", "0101", "0104"],
            ["春节假期", "0131", "0207"],
            ["春节补休上班", "0130", "0131"],
            ["春节补休上班", "0129", "0130"],
            ["清明节假期", "0402", "0403"],
            ["清明节假期", "0403", "0406"],
            ["劳动节补休上班", "0424", "0425"],
            ["劳动节假期", "0430", "0505"],
            ["劳动节补休上班", "0507", "0508"],
            ["端午节假期", "0603", "0606"],
            ["中秋节假期", "0910", "0913"],
            ["国庆日假期", "1001", "1008"],
            ["国庆补休上班", "1008", "1010"],
        ]
    }

    content = create_isc_content(event_list)
    fh = open("china-official-holidays.ics", 'w')
    fh.write(content)
    fh.close()
