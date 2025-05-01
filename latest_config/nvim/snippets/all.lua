local fmt = require('luasnip.extras.fmt').fmt
return {
  -- important! fmt does not return a snippet, it returns a table of nodes.
  s(
    'example1',
    fmt('just an {iNode1}', {
      iNode1 = i(1, 'example'),
    })
  ),
  s(
    'example2',
    fmt(
      [[
  if {} then
    {}
  end
  ]],
      {
        -- i(1) is at nodes[1], i(2) at nodes[2].
        i(1, 'not now'),
        i(2, 'when'),
      }
    )
  ),
  s(
    'example3',
    fmt(
      [[
  if <> then
    <>
  end
  ]],
      {
        -- i(1) is at nodes[1], i(2) at nodes[2].
        i(1, 'not now'),
        i(2, 'when'),
      },
      {
        delimiters = '<>',
      }
    )
  ),
  s(
    'example4',
    fmt(
      [[
  repeat {a} with the same key {a}
  ]],
      {
        a = i(1, 'this will be repeat'),
      },
      {
        repeat_duplicates = true,
      }
    )
  ),
  s(
    'example5',
    fmt(
      [[
    line1: no indent

      line3: 2 space -> 1 indent ('\t')
        line4: 4 space -> 2 indent ('\t\t')
  ]],
      {},
      {
        indent_string = '  ',
      }
    )
  ),
  -- NOTE: [[\t]] means '\\t'
  s(
    'example6',
    fmt(
      [[
    line1: no indent

    \tline3: '\\t' -> 1 indent ('\t')
    \t\tline4: '\\t\\t' -> 2 indent ('\t\t')
  ]],
      {},
      {
        indent_string = [[\t]],
      }
    )
  ),
  s(
    'BEGIN_PUBLIC',
    fmt(
      [[
      BEGIN_PUBLIC

      {}

      END_PUBLIC

  ]],
      {
        -- i(1) is at nodes[1]
        i(1, 'Internal change'),
      }
    )
  ),
  s('BUG', t('BUG=411727687')),
  s('TODO', t('// TODO: b/411727687 - ')),
}
