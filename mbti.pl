mbti_name(i, 'Introversion').
mbti_name(e, 'Extraversion').
mbti_name(s, 'Sensing').
mbti_name(n, 'Intuition').
mbti_name(t, 'Thinking').
mbti_name(f, 'Feeling').
mbti_name(j, 'Judging').
mbti_name(p, 'Perceiving').

% キーワードと関連するMBTI特性
keyword('alone', i).
keyword('energized', e).
keyword('socialize', e).
keyword('facts', s).
keyword('intuition', n).
keyword('think', t).
keyword('feel', f).
keyword('plan', j).
keyword('spontaneous', p).

mbti_personality(istj, [i, s, t, j]).
mbti_personality(isfj, [i, s, f, j]).
mbti_personality(infj, [i, n, f, j]).
mbti_personality(intj, [i, n, t, j]).
mbti_personality(istp, [i, s, t, p]).
mbti_personality(isfp, [i, s, f, p]).
mbti_personality(infp, [i, n, f, p]).
mbti_personality(intp, [i, n, t, p]).
mbti_personality(estp, [e, s, t, p]).
mbti_personality(esfp, [e, s, f, p]).
mbti_personality(enfp, [e, n, f, p]).
mbti_personality(entp, [e, n, t, p]).
mbti_personality(estj, [e, s, t, j]).
mbti_personality(esfj, [e, s, f, j]).
mbti_personality(enfj, [e, n, f, j]).
mbti_personality(entj, [e, n, t, j]).


personality_name(istj, 'The Inspector').
personality_name(isfj, 'The Protector').
personality_name(infj, 'The Counselor').
personality_name(intj, 'The Mastermind').
personality_name(istp, 'The Craftsman').
personality_name(isfp, 'The Composer').
personality_name(infp, 'The Healer').
personality_name(intp, 'The Architect').
personality_name(estp, 'The Dynamo').
personality_name(esfp, 'The Performer').
personality_name(enfp, 'The Champion').
personality_name(entp, 'The Visionary').
personality_name(estj, 'The Supervisor').
personality_name(esfj, 'The Provider').
personality_name(enfj, 'The Teacher').
personality_name(entj, 'The Commander').



find(Keyword, Name) :- keyword(Keyword, Trait), mbti_name(Trait, Name).

% Personalities = ['Introversion', 'Sensing', 'Thinking', 'Judging']
find_personality_name([N1, N2, N3, N4], PersonalityName) :- 
    mbti_name(T1, N1), mbti_name(T2, N2), mbti_name(T3, N3), mbti_name(T4, N4),
    mbti_personality(Personality, [T1, T2, T3, T4]),
    personality_name(Personality, PersonalityName).
    
