# -*- coding: utf-8 -*-


class ModuleList(object):
    """
    concatenate part of SQL queries
    """

    def __init__(self):
        """
        dict of SQL parts
        """
        self.try_dict = \
            {
                'prom': [u'sql_2\n', 'text 1']

                , 'calc': [u'sql_2\n', 'text2']

                , 'users': [u'INSERT INTO users name=%s,gender=%s,age=%s\n', 'text3', ('Имя', 'Пол', 'Возраст')]

                , 'days_befor_out': [u'sql_4\n', 'text4']
            }

        self.concate = u'''
SELECT top 10
  count(d.id)
FROM
  i_collect.dbo.bank as b
  inner join i_collect.dbo.portfolio as p on b.id = p.parent_id
  inner join i_collect.dbo.debt as d on p.id = d.r_portfolio_id
  inner join i_collect.dbo.person as per on d.parent_id = per.id
'''

    def concatenator(self):
        """
        concate SQL parts
        """
        for k, v in self.try_dict.items():
            print k, v[1]

        r = raw_input('\nlist of moduls use: ')
        r = r.replace(' ', '').split(',')

        result_query = self.concate
        for module in r:
            if module in self.try_dict:
                query, description, fields = self.try_dict[module]
                params = []
                print description
                for field in fields:
                    value = raw_input('Введите %s :' % field)
                    params.append(value)
                query = query % tuple(params)
                result_query = '\n'.join([result_query, query])
        print result_query

if __name__ == '__main__':

    ModuleList().concatenator()