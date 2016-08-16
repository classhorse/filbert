#мутим табличку
import sys

reload(sys)
sys.setdefaultencoding('utf8')


headers = [colored(u'Предикат', 'yellow'), colored(u'Описание', 'yellow'), colored(u'Пример', 'yellow')]
        data = [
            [self.m('in'), u'Список', self.m(u'in (49, 14)')]
            ,[self.m('not in'), u'Список исключений', self.m(u'not in (6,7,8,10)')]
            ,
        ]
        print tabulate(data, headers=headers, tablefmt="fancy_grid")